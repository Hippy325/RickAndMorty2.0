//
//  HTTPTransport.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine

final class HTTPTransport {

	// MARK: - Properties

	private let session: URLSession
	private let decoder: JSONDecoder

	// MARK: - Init

	init(session: URLSession, decoder: JSONDecoder) {
		self.session = session
		self.decoder = decoder
	}
}

// MARK: - Protocol implementation

extension HTTPTransport: IHTTPTransport {

	enum Error: String, Swift.Error {
		case invalidUrl
	}

	func loadData(stringUrl: String) -> AnyPublisher<Data, Swift.Error> {
		guard let url = URL(string: stringUrl) else { return Fail(error: Error.invalidUrl).eraseToAnyPublisher() }

		return loadData(url: url)
	}

	func load<T>(stringUrl: String, responseType: T.Type) -> AnyPublisher<T, Swift.Error> where T : Decodable {
		guard let url = URL(string: stringUrl) else { return Fail(error: Error.invalidUrl).eraseToAnyPublisher() }

		return load(url: url, responseType: responseType.self)
	}

	func loadData(url: URL) -> AnyPublisher<Data, Swift.Error> {
		session.dataTaskPublisher(for: url)
			.map { $0.data }
			.catch { Fail(error: $0) }
			.eraseToAnyPublisher()
	}

	func load<T>(url: URL, responseType: T.Type) -> AnyPublisher<T, Swift.Error> where T : Decodable {
		session.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: responseType.self, decoder: decoder)
			.catch { Fail(error: $0) }
			.eraseToAnyPublisher()
	}
}

