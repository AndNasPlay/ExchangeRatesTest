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

	private let rid = "BEYkZbmV"

	private let uid = "563B4852-6D4B-49D6-A86E-B273DD520FD2"

	private let type = "ExchangeRates&v=44"

	private init() {}

	func getRequestForRates(completion: @escaping (RatesResults?, String?) -> Void) {

		let endURL = baseURL + "?r=\(rid)" + "&d=\(uid)&" + "&t=\(type)"

		guard let url = URL(string: endURL) else {
			completion(nil, "Ошибка Url Адреса")
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
				completion(nil, "Ошибка data")
				return
			}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(nil, "Ошибка statusCode")
				return
			}

			do {
				let responseData = try JSONDecoder().decode(RatesResults.self, from: data)
				let alertMessage = """
 Message: \(responseData.message ?? "12"),
 Product State: \(responseData.productState ?? 12),
 DownloadDate: \(responseData.downloadDate ?? "12"),
 Rid: \(responseData.rid ?? "12"),
 RatesDate: \(responseData.ratesDate ?? "12"),
 MessageTitle: \(responseData.messageTitle ?? "12"),
 Code: \(responseData.code ?? 12)
 """
				completion(responseData, alertMessage)

			} catch {
				print(error.localizedDescription)
				completion(nil, error.localizedDescription)
			}
		}
		task.resume()
	}
}
