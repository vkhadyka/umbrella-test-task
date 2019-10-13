//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainPresenterProtocol: BasePresenterProtocol {
	func updateWeather()
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
