//
//  ApiClient.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 09.07.2022.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: AnyObject {
	associatedtype EndPoint: EndPointType
	func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
	func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
	private var task: URLSessionTask?

	func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
		let session = URLSession.shared
		do {
			let request = try self.buildRequest(from: route)
			task = session.dataTask(with: request, completionHandler: { data, response, error in
				completion(data, response, error)
			})
		} catch {
			completion(nil, nil, error)
		}
		self.task?.resume()
	}

	func cancel() {
		self.task?.cancel()
	}

	fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {

		var request = URLRequest(url: route.baseURL,
								 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
								 timeoutInterval: 10.0)

		request.httpMethod = route.httpMethod.rawValue
		do {
			switch route.task {
			case .request:
				request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			case .requestParameters(let bodyParameters,
									let bodyEncoding,
									let urlParameters):

				try self.configureParameters(bodyParameters: bodyParameters,
											 bodyEncoding: bodyEncoding,
											 urlParameters: urlParameters,
											 request: &request)

			case .requestParametersAndHeaders(let bodyParameters,
											  let bodyEncoding,
											  let urlParameters,
											  let additionalHeaders):

				self.addAdditionalHeaders(additionalHeaders, request: &request)
				try self.configureParameters(bodyParameters: bodyParameters,
											 bodyEncoding: bodyEncoding,
											 urlParameters: urlParameters,
											 request: &request)
			}
			return request
		} catch {
			throw error
		}
	}

	fileprivate func configureParameters(
		bodyParameters: Parameters?,
		bodyEncoding: ParameterEncoding,
		urlParameters: Parameters?,
		request: inout URLRequest) throws {

		do {
			try bodyEncoding.encode(urlRequest: &request,
									bodyParameters: bodyParameters, urlParameters: urlParameters)
		} catch {
			throw error
		}
	}

	fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
		guard let headers = additionalHeaders else { return }
		for (key, value) in headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
	}

}

enum NetworkResponse: String {
	case success
	case authenticationError = "You need to be authenticated first."
	case badRequest = "Bad request"
	case outdated = "The url you requested is outdated."
	case failed = "Network request failed."
	case noData = "Response returned with no data to decode."
	case unableToDecode = "We could not decode the response."
}

enum Result<String> {
	case success
	case failure(String)
}

struct NetworkManager {
	let router = Router<CurrencyApi>()

	func getCurrencies(completion: @escaping (_ currency: CurrencyData?, _ error: String?) -> Void) {
		router.request(.base) { data, response, error in

			if error != nil {
				completion(nil, "Please check your network connection.")
			}

			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, NetworkResponse.noData.rawValue)
						return
					}
					do {
						let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
						print(jsonData)
						let apiResponse = try JSONDecoder().decode(CurrencyData.self, from: responseData)
						print(apiResponse)
						completion(apiResponse, nil)
					} catch {
						print(error)
						completion(nil, NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError):
					completion(nil, networkFailureError)
				}
			}
		}
	}

	fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200...299: return .success
		case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
		case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
		case 600: return .failure(NetworkResponse.outdated.rawValue)
		default: return .failure(NetworkResponse.failed.rawValue)
		}
	}
}
