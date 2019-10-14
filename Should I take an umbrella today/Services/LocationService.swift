//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import CoreLocation

typealias PlaceByCoordinatesCompletionHandler = (CLPlacemark?) -> Void

protocol LocationServiceProtocol: class {
	var location: CLLocation? {get}
	func setDelegate(delegate: LocationManagerDelegate)
	func getPlaceByLocation(completion: @escaping PlaceByCoordinatesCompletionHandler)
	func requestLocation()
}

class LocationService: NSObject, LocationServiceProtocol {

	//MARK: Private variables
	private var locationManager = CLLocationManager()
	private var delegate: LocationManagerDelegate?

	//MARK: Public variables
	var location: CLLocation? {
		locationManager.location
	}

	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.showsBackgroundLocationIndicator = true
		locationManager.requestWhenInUseAuthorization()
	}

	func setDelegate(delegate: LocationManagerDelegate) {
		self.delegate = delegate
	}

	func requestLocation() {
		locationManager.requestLocation()
	}
}

extension LocationService: CLLocationManagerDelegate {
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse || status == .authorizedAlways {
			manager.requestLocation()
		}
	}

	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let delegate = delegate else {return}
		delegate.didLocationUpdated()
	}

	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		guard let delegate = delegate else {return}
		delegate.failWithError(error: error)
	}
}

extension LocationService {

	//Get place by coordinates
	func getPlaceByLocation(completion: @escaping PlaceByCoordinatesCompletionHandler) {

		guard let location = location else {
			completion(nil)
			return
		}
		let geocoder = CLGeocoder()

		//convert coordinates ro user-friendly place
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
