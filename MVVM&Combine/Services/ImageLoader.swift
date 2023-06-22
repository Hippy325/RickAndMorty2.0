//
//  ImageLoader.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import Combine
import UIKit


protocol IImageLoader {
	func loadImage(
		from url: URL?
	) -> AnyPublisher<UIImage?, Swift.Error>
}

final class ImageLoaderPublisher: IImageLoader {

	enum Error: String, Swift.Error {
		case cannotConvertDataToImage
		case invalidURL
	}

	private let lock = NSLock()
	private var images = NSCache<NSString, UIImage>()
	private var cancellable = Set<AnyCancellable>()

	private let httpTransport: IHTTPTransport

	init(httpTransport: IHTTPTransport) {
		self.httpTransport = httpTransport
	}

	private func set(image: UIImage, for url: URL) {
		lock.lock()
		images.setObject(image, forKey: url.absoluteString as NSString)
		lock.unlock()
	}

	private func get(for url: URL) -> UIImage? {
		lock.lock()
		let image = images.object(forKey: url.absoluteString as NSString)
		lock.unlock()
		return image
	}

	func loadImage(from url: URL?) -> AnyPublisher<UIImage?, Swift.Error> {
		guard let url = url else { return Fail(error: Error.invalidURL).eraseToAnyPublisher() }

		if let image = get(for: url) {
			return Just(image)
				.setFailureType(to: Swift.Error.self)
				.eraseToAnyPublisher()
		}

		return httpTransport.loadData(url: url)
			.tryMap { data -> UIImage in
				guard let image = UIImage(data: data) else { throw Error.cannotConvertDataToImage }
				self.set(image: image, for: url)
				return image
			}
			.eraseToAnyPublisher()
	}
}


