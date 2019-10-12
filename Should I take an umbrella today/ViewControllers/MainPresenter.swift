//
// Created by Vadim Khadyka on 10/12/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: BasePresenterProtocol {
}

class MainPresenter: MainPresenterProtocol {

	//MARK: Private variables
	fileprivate var view: MainViewProtocol

	init(view: MainViewProtocol){
		self.view = view
	}
	func viewDidLoad() {

	}
}
