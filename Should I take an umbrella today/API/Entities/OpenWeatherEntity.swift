//
// Created by Vadim Khadyka on 10/13/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

// MARK: - OpenWeatherEntity
struct OpenWeatherEntity: Codable {
	let cod: String
	let message: Double
	let cnt: Int
	let list: [List]
	let city: City
}

// MARK: - City
struct City: Codable {
	let id: Int
	let name: String
	let coord: Coord
	let country: String
}

// MARK: - Coord
struct Coord: Codable {
	let lat, lon: Double
}

// MARK: - List
struct List: Codable {
	let dt: Int
	let weather: [WeatherElement]

	enum CodingKeys: String, CodingKey {
		case dt, weather

	}
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
	let id: Int
	let main: String
	let weatherDescription: String
	let icon: String

	enum CodingKeys: String, CodingKey {
		case id, main
		case weatherDescription = "description"
		case icon
	}
}
