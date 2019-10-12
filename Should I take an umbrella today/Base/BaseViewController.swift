//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseViewProtocol {

	func showHUD() {

	}

	func hideHUD() {

	}

    func showError(errorMessage: String) {
		let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
		let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(alertAction)
		self.present(alert, animated: true, completion: nil)
    }

}
