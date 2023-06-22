//
//  DetailModel.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation
import Combine
import UIKit

struct DetailModel {
	let name: String
	let race: String
	let gender: String
	let status: String
	let location: String
	let countEpisode: String

	let image: AnyPublisher<UIImage?, Never>
}
