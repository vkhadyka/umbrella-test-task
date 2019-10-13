//
// Created by Vadim Khadyka on 10/13/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import CoreLocation
import Moya

typealias UpdateWeatherGatewayCompletionHandler = (_ weather: Result<OpenWeatherEntity>) -> Void

protocol ApiGatewayProtocol: class {
	func getWeather(by city: String, completionHandler: @escaping UpdateWeatherGatewayCompletionHandler)
	func getWeather(by location: CLLocationCoordinate2D, completionHandler: @escaping UpdateWeatherGatewayCompletionHandler)
}

class ApiGateway: ApiGatewayProtocol {

	//MARK: Private variables
	fileprivate var provider = MoyaProvider<ApiService>()

	init() {

	}

	func getWeather(by city: String, completionHandler: @escaping UpdateWeatherGatewayCompletionHandler) {
		provider.request(.getWeatherByCity(city: city)) { result in
			switch result {
			case let .success(response):
				do {
					let filteredResponse = try response.filterSuccessfulStatusCodes()
					let weather = try filteredResponse.map(OpenWeatherEntity.self)
					completionHandler(.success(weather))

				} catch let error {
					completionHandler(.failure(error))
				}
			case let .failure(error):
				completionHandler(.failure(error))
			}
		}
	}


	func getWeather(by location: CLLocationCoordinate2D, completionHandler: @escaping UpdateWeatherGatewayCompletionHandler) {
		provider.request(.getWeatherByLocation(location: location)) { result in
			switch result {
			case let .success(response):
				do {
					let filteredResponse = try response.filterSuccessfulStatusCodes()
					let weather = try filteredResponse.map(OpenWeatherEntity.self)
					completionHandler(.success(weather))

				} catch let error {
					completionHandler(.failure(error))
				}
			case let .failure(error):
				completionHandler(.failure(error))
			}
		}
	}
}
