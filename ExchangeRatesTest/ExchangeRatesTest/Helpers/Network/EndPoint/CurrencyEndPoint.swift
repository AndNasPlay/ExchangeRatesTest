//
//  CurrencyEndPoint.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 09.07.2022.
//

import Foundation

public enum CurrencyApi {
	case base
}

extension CurrencyApi: EndPointType {

	var baseURL: URL {

		var components = URLComponents()
		components.scheme = "https"
		components.host = "alpha.as50464.net"
		components.path =  path
		components.port = 29870
		components.queryItems = queryItems
		print(components.url?.absoluteString as Any)

		return components.url!
	}

	var path: String {
		switch self {
		case .base:
			return "/moby-pre-44/core"
		}
	}

	var queryItems: [URLQueryItem] {
		switch self {
		case .base:
			return [
				URLQueryItem(name: "r", value: "BEYkZbmV"),
				URLQueryItem(name: "d", value: "563B4852-6D4B-49D6-A86E-B273DD520FD2"),
				URLQueryItem(name: "t", value: "ExchangeRates"),
				URLQueryItem(name: "v", value: "44")
			]
		}
	}

	var httpMethod: HTTPMethod {
		return .post
	}

	var bodyJSON: [String: String] {
		return [
			"uid": "563B4852-6D4B-49D6-A86E-B273DD520FD2",
			"type": "ExchangeRates&v=44",
			"rid": "BEYkZbmV"
		]
	}

	var task: HTTPTask {
		switch self {
		case .base:
			return .requestParametersAndHeaders(bodyParameters: bodyJSON,
												bodyEncoding: .jsonEncoding,
												urlParameters: nil,
												additionHeaders: headers)
		}
	}

	var headers: HTTPHeaders? {
		return [
			"User-Agent": "Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)",
			"Content-Type": "application/json",
			"Accept": "application/json"
		]
	}
}
