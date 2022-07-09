//
//  JSONParameterEncoder.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 09.07.2022.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
	public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		do {
			let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			urlRequest.httpBody = jsonAsData
			urlRequest.addValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)",
								forHTTPHeaderField: "User-Agent")
			urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
			urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
		} catch {
			throw NetworkError.encodingFailed
		}
	}
}
