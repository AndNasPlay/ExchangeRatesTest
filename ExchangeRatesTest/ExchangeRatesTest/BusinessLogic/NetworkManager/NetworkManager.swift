//
//  NetworkManager.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 21.05.2022.
//

import Foundation

class NetworkManager {

	static let shared = NetworkManager()

	let API_KEY = "a6a67538b84590d5c50503ff3b51b1ce"
	let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"

	private init() {}

	func getRequest(completed: @escaping ([Rates]?) -> Void) {

		guard let url = URL(string: "https://alpha.as50464.net:29870/moby-pre-44/core?r=BEYkZbmV&d=563B4852-6D4B-49D6-A86E-B273DD520FD2&t=ExchangeRates&v=44") else {
			completed(nil)
			return

		}

		let bodyJSON: [String: Any] = [
			"uid": "563B4852-6D4B-49D6-A86E-B273DD520FD2",
			"type": "ExchangeRates",
			"rid": "BEYkZbmV"
		]

		let body = try? JSONSerialization.data(withJSONObject: bodyJSON)

		var request = URLRequest(url: url)

		request.httpMethod = "POST"
		request.addValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)", forHTTPHeaderField: "User-Agent")
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.httpBody = body

		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				completed(nil)
				return
			}
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completed(nil)
				return
			}

			do {
				let responseData = try JSONDecoder().decode(RatesResults.self, from: data)
				guard let dataForArray = responseData.rates else {
					completed(nil)
					return
				}
				completed(dataForArray)
			} catch {
				print(error.localizedDescription)
				completed(nil)
			}
		}
		task.resume()
	}
}