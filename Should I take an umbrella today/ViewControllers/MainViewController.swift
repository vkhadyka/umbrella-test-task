//
//  MainViewController.swift
//  Should I take an umbrella today
//
//  Created by Vadim Khadyka on 10/12/19.
//  Copyright © 2019 Vadim Khadyka. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainViewProtocol {

	var presenter: MainPresenterProtocol!

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.viewDidLoad()
	}

	//MARK: Display presenter data
	func display(city: String, country: String) {

	}

	func display(lastUpdateDate: Date) {

	}

	func display(image: String) {

	}

	func display(weatherDescription: String) {

	}

}
