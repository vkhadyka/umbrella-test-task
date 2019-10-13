//
// Created by Vadim Khadyka on 10/13/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import CoreLocation
import Moya

enum ApiService {
	case getWeatherByLocation(location: CLLocationCoordinate2D)
	case getWeatherByCity(city: String)
}

extension ApiService: TargetType {

    var baseURL: URL {
		URL(string: Endpoints.baseURL )!
    }

    var path: String {
		switch self {
			case .getWeatherByLocation, .getWeatherByCity:
			return "/forecast/"
		}
    }

    var method: Moya.Method {
        switch self {
		case .getWeatherByCity, .getWeatherByLocation:
			return .get
		}
    }

    var task: Task {
        switch self {
		case .getWeatherByLocation(let location):
			return .requestParameters(parameters: ["lat": location.latitude,
													"lon": location.longitude,
													"appId": ApiKeys.openWeatherApiKey],
					encoding: URLEncoding.queryString)

		case .getWeatherByCity(let city):
			return .requestParameters(parameters: ["q": city,
													"appId": ApiKeys.openWeatherApiKey],
					encoding: URLEncoding.queryString)
		}
    }

	var headers: [String: String]? {
		["Content-type": "application/json"]
	}

	var sampleData: Data {
		Data()
	}
}
