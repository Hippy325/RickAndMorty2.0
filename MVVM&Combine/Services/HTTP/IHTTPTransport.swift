//
//  IHTTPTransport.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine

protocol IHTTPTransport {

	func loadData(
		stringUrl: String
	) -> AnyPublisher<Data, Error>

	func load<T: Decodable>(
		stringUrl: String,
		responseType: T.Type
	) -> AnyPublisher<T, Error>

	func loadData(
		url: URL
	) -> AnyPublisher<Data, Error>

	func load<T: Decodable>(
		url: URL,
		responseType: T.Type
	) -> AnyPublisher<T, Error>
}
