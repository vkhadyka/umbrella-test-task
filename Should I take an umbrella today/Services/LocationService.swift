//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import CoreLocation

typealias PlaceByCoordinatesCompletionHandler = (CLPlacemark?) -> Void

class LocationService: NSObject {

	//MARK: Private variables
	private var locationManager = CLLocationManager()

	//MARK: Public variables
	var location: CLLocation? {
		locationManager.location
	}

	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestAlwaysAuthorization()
	}
}

extension LocationService: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse || status == .authorizedAlways {
			manager.requestLocation()
		}
	}
}

extension LocationService {

	//Get place by coordinates
	func getPlaceByLocation(for location: CLLocation, completion: @escaping PlaceByCoordinatesCompletionHandler) {

		let geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(location, preferredLocale: nil) { placemarks, error in

			guard error == nil else {
				completion(nil)
				return
			}

			guard let placemark = placemarks?.first else {
				completion(nil)
				return
			}

			completion(placemark)
		}
	}
}
