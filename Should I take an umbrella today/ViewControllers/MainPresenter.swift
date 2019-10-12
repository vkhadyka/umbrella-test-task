//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: BasePresenterProtocol {
	func updateWeather()
}

class MainPresenter: MainPresenterProtocol {

	//MARK: Private variables
	fileprivate var locationService: LocationService?
	fileprivate var view: MainViewProtocol

	init(view: MainViewProtocol){
		self.view = view
	}

	func viewDidLoad() {
		self.locationService = LocationService()
		updateWeather()
	}

	func updateWeather() {

		guard let coordinates = locationService?.location else {
			view.showError(errorMessage: "Unable to get coordinates")
			return
		}

		locationService?.getPlaceByLocation(for: coordinates) { placemark in
			guard let placemark = placemark else {
				return
			}

		}
	}
}
