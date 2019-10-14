//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

protocol MainViewProtocol: BaseViewProtocol {
	func display(city: String, country: String)
	func display(lastUpdateDate: String)
	func display(isRainy: Bool)
}
