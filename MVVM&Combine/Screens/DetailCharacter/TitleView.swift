//
//  TitleView.swift
//  MVVM&Combine
//
//  Created by User on 18.06.2023.
//

import Foundation
import UIKit

final class TitleView: UIView {
	private let titleView = UILabel()

	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		addSubview(titleView)

		titleView.adjustsFontSizeToFitWidth = true
		titleView.numberOfLines = 1
		titleView.font = UIFont.systemFont(ofSize: 25)

		setupLayout()
	}

	private func setupLayout() {
		titleView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			titleView.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleView.heightAnchor.constraint(equalToConstant: 50),
			titleView.widthAnchor.constraint(equalTo: widthAnchor)
		])
	}

	func setup(title: String) {
		titleView.text = title
	}
}
