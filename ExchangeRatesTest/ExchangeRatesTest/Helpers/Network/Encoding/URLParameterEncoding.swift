//
//  URLParameterEncoding.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 09.07.2022.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
	public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {

		guard let url = urlRequest.url else { throw NetworkError.missingURL }

		if var urlComponents = URLComponents(url: url,
											 resolvingAgainstBaseURL: false), !parameters.isEmpty {

			urlComponents.queryItems = [URLQueryItem]()

			for (key, value) in parameters {
				let queryItem = URLQueryItem(name: key,
											 value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			urlRequest.url = urlComponents.url
		}
		urlRequest.addValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)",
							forHTTPHeaderField: "User-Agent")
		urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
		urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

	}
}
