//
// Created by Vadim Khadyka on 10/13/19.
// Copyright (c) 2019 Vadim Khadyka. All rights reserved.
//

import Foundation

enum Result<T> {

	case success(T)
	case failure(Error)

	public func dematerialize() throws -> T {
		switch self {
		case let .success(value):
			return value
		case let .failure(error):
			throw error
		}
	}
}
