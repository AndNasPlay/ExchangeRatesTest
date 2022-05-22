//
//  NetworkManager.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import UIKit

class NetworkManager {

	static let shared = NetworkManager()

	private let baseURL = "https://alpha.as50464.net:29870/moby-pre-44/core"

	private let baseURLForFlag = "https://countryflagsapi.com/png/"

	private let rid = "BEYkZbmV"

	private let uid = "563B4852-6D4B-49D6-A86E-B273DD520FD2"

	private let type = "ExchangeRates&v=44"

	private init() {}

	func loadImage(flagCode: String, completion: @escaping(UIImage?) -> Void) {

		let urlString = baseURLForFlag + "\(flagCode)"
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else {
				completion(nil)
				return
			}
			let image = UIImage(data: data)
			completion(image)
		}.resume()
	}

	func getRequestForRates(completion: @escaping ([Rates]?) -> Void) {

		let endURL = baseURL + "?r=\(rid)" + "&d=\(uid)&" + "&t=\(type)"

		guard let url = URL(string: endURL) else {
			completion(nil)
			return
		}

		let bodyJSON: [String: String] = [
			"uid": "\(uid)",
			"type": "\(type)",
			"rid": "\(rid)"
		]

		let body = try? JSONSerialization.data(withJSONObject: bodyJSON)

		var request = URLRequest(url: url)

		request.httpMethod = "POST"
		request.addValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)",
						 forHTTPHeaderField: "User-Agent")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.httpBody = body

		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				completion(nil)
				return
			}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(nil)
				return
			}

			do {
				let responseData = try JSONDecoder().decode(RatesResults.self, from: data)
				guard let dataForArray = responseData.rates else {
					completion(nil)
					return
				}
				completion(dataForArray)
			} catch {
				print(error.localizedDescription)
				completion(nil)
			}
		}
		task.resume()
	}
}
