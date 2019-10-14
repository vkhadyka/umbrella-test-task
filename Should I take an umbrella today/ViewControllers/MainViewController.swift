//
//  MainViewController.swift
//  Should I take an umbrella today
//
//  Created by Vadim Khadyka on 10/12/19.
//  Copyright © 2019 Vadim Khadyka. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MainViewProtocol {

	
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var updateDate: UILabel!
	@IBOutlet weak var umbrellaImage: UIImageView!
	
	//MARK: Public variables
	var presenter: MainPresenterProtocol!

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.viewDidLoad()
	}

	//MARK: Display presenter data
	func display(city: String, country: String) {
		self.title = "\(city), \(country)"
	}

	func display(lastUpdateDate: String) {
		updateDate.text = lastUpdateDate
	}

	@IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
		presenter.requestUpdate()
	}

	func display(isRainy: Bool) {
		umbrellaImage.tintColor = isRainy ? .orange : .lightGray
		descriptionLabel.text = isRainy ? "There are going to rain. Take an umbrella" : "No rain. You can leave an umbrella at home"
	}
}
