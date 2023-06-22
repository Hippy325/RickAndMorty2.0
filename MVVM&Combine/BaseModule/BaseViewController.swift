//
//  BaseViewController.swift
//  MVVM&Combine
//
//  Created by User on 19.06.2023.
//

import Foundation
import UIKit

class BaseViewController<S: IState, ViewModel: BaseViewModel<S>>: UIViewController {
	let viewModel: ViewModel

	init(viewModel: ViewModel) {
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		viewModel.send(.onAppear())
	}
}
