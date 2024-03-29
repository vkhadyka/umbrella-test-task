//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

protocol BaseViewProtocol: class {
	func showHUD()
	func hideHUD()
	func showError(errorMessage: String)
}
