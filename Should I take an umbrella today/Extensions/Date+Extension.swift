//
// Created by Vadim Khadyka on 10/14/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation
extension Date {
	var formattedDate: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM dd, yyyy 'at' hh:mm:ss"
		return formatter.string(from: self)
	}
}
