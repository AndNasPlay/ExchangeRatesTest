//
//  NetworkRouter.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 10.07.2022.
//

import Foundation

protocol NetworkRouter: AnyObject {
	associatedtype EndPoint: EndPointType
	func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
	func cancel()
}
