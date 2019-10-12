//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

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

	init(view: MainViewProtocol){
		self.view = view
	}

	func viewDidLoad() {
		self.locationService = LocationService()
		self.locationService?.setDelegate(delegate: self)
	}

	func updateWeather() {

		guard let locationService = locationService else {return}

		guard let coordinates = locationService.location else {
			view.showError(errorMessage: "Unable to get coordinates")
			return
		}

		locationService.getPlaceByLocation() { placemark in
			guard let placemark = placemark else {
				return
			}

		}
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
