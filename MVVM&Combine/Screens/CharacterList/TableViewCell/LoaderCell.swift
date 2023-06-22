//
//  LoaderCell.swift
//  MVVM&Combine
//
//  Created by User on 16.06.2023.
//

import Foundation
import UIKit

final class LoaderCell: UITableViewCell {
	private let activityIndicator = UIActivityIndicatorView()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private func setup() {
		addSubview(activityIndicator)
		backgroundColor = .clear
		activityIndicator.color = .red
		activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
		setupLayout()
	}

	private func setupLayout() {
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	func startAnimation() {
		activityIndicator.startAnimating()
	}
}
