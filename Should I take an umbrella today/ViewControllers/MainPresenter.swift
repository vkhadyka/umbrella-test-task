//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainPresenterProtocol: BasePresenterProtocol {
	func updateWeather()
	func requestUpdate()
}

protocol LocationManagerDelegate: class {
	func didLocationUpdated()
	func failWithError(error: Error)
}

class MainPresenter: MainPresenterProtocol {

	//MARK: Private variables
	fileprivate var locationService: LocationServiceProtocol?
	fileprivate var view: MainViewProtocol
	fileprivate var apiGateway: ApiGatewayProtocol?

	init(view: MainViewProtocol) {
		self.view = view
	}

	func viewDidLoad() {
		self.locationService = LocationService()
		self.locationService?.setDelegate(delegate: self)
		self.apiGateway = ApiGateway()
		if let lastDate = UserDefaults.standard.value(forKey: UserDefaultKeys.lastUpdateDate) as? Date {
			view.display(lastUpdateDate: lastDate.formattedDate)
		}
	}

	func updateWeather() {

		guard let apiGateway = apiGateway else {
			return
		}
		guard let locationService = locationService else {
			return
		}

		guard let coordinates = locationService.location?.coordinate else {
			view.showError(errorMessage: "Unable to get coordinates")
			return
		}

		locationService.getPlaceByLocation() { [weak self] placemark in
			guard let placemark = placemark else {
				self?.weatherRequest(apiGateway: apiGateway, coordinates: coordinates)
				return
			}
			self?.weatherRequest(apiGateway: apiGateway, city: placemark.locality!)
		}
	}

	private func weatherRequest(apiGateway: ApiGatewayProtocol, city: String) {
		apiGateway.getWeather(by: city) { [weak self] result in
			switch result {
			case let .success(weather):
				self?.handleWeatherReceived(weather: weather)
			case let .failure(error):
				self?.view.showError(errorMessage: error.localizedDescription)
			}
		}
	}

	private func weatherRequest(apiGateway: ApiGatewayProtocol, coordinates: CLLocationCoordinate2D) {
		apiGateway.getWeather(by: coordinates) { [weak self] result in
			switch result {
			case let .success(weather):
				self?.handleWeatherReceived(weather: weather)
			case let .failure(error):
				self?.view.showError(errorMessage: error.localizedDescription)
			}
		}
	}

	private func handleWeatherReceived(weather: OpenWeatherEntity) {

		//add 12 hours from current time and convert to seconds since 1970
		let modifiedDate = Int((Calendar.current.date(byAdding: .hour, value: 12, to: Date())?.timeIntervalSince1970.rounded())!)
		//select all weather records for next 12 hours
		let selectedWeather = weather.list.filter { $0.dt <= modifiedDate }.map { $0.weather.first }
		//check either description contains rain or sleet words
		let isRainy = selectedWeather.contains(where: {($0?.weatherDescription.contains("rain"))! || ($0?.weatherDescription.contains("sleet"))!})
		//get current date
		let date = Date()
		//save date
		UserDefaults.standard.set(date, forKey: UserDefaultKeys.lastUpdateDate)
		view.display(isRainy: isRainy)
		view.display(lastUpdateDate: date.formattedDate)
		view.display(city: weather.city.name, country: weather.city.country)

	}

	func requestUpdate() {
		guard let locationService = locationService else {return}
		locationService.requestLocation()
	}
}

extension MainPresenter: LocationManagerDelegate {
	func failWithError(error: Error) {
		view.showError(errorMessage: error.localizedDescription)
	}

	func didLocationUpdated() {
		updateWeather()
	}
}
