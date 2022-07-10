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
			let jsonAsData = try JSONSerialization.data(withJSONObject: parameters)
			urlRequest.httpBody = jsonAsData
		} catch {
			throw NetworkError.encodingFailed
		}
	}
}
