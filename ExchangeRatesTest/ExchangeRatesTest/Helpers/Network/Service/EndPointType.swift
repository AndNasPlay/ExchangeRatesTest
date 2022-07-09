//
//  EndPointType.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 09.07.2022.
//

import Foundation

protocol EndPointType {
	var baseURL: URL { get }
	var queryItems: [URLQueryItem] { get}
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var task: HTTPTask { get }
	var headers: HTTPHeaders? { get }
	var bodyJSON: [String: String] { get }
}
