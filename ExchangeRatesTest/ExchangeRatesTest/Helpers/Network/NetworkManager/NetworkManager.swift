//
//  NetworkManager.swift
//  ExchangeRatesTest
//
//  Created by Андрей Щекатунов on 11.07.2022.
//

import Foundation

struct NetworkManager {

	static let shared = NetworkManager()

	let router = Router<CurrencyApi>()

	func getCurrencies(completion: @escaping (_ currency: RatesResults?,
											  _ alertMessage: String?,
											  _ error: String?) -> Void) {
		router.request(.base) { data, response, error in

			if error != nil {
				completion(nil, nil, "Please check your network connection.")
			}

			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				switch result {
				case .success:
					guard let responseData = data else {
						completion(nil, nil, NetworkResponse.noData.rawValue)
						return
					}
					do {
						let apiResponse = try JSONDecoder().decode(RatesResults.self, from: responseData)
						let alertMessage =
											 """
											 Message: \(apiResponse.message),
											 Product State: \(apiResponse.productState ?? 0),
											 DownloadDate: \(apiResponse.downloadDate ?? "Download Date"),
											 Rid: \(apiResponse.rid ?? "Rid"),
											 RatesDate: \(apiResponse.ratesDate ?? "RatesDate"),
											 MessageTitle: \(apiResponse.messageTitle ?? "MessageTitle"),
											 Code: \(apiResponse.code ?? 0)
											 """
						completion(apiResponse, alertMessage, nil)
					} catch {
						completion(nil, nil, NetworkResponse.unableToDecode.rawValue)
					}
				case .failure(let networkFailureError):
					completion(nil, nil, networkFailureError)
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
