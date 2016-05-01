//
//  RXLoansViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXLoansViewController: UIViewController {

	// MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.addGestureRecgnizer()
	}

	private func addGestureRecgnizer() {

		let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.closeLoansView))
		closeGestureRecognizer.direction = .Down
		closeGestureRecognizer.delaysTouchesBegan = true
		self.view.addGestureRecognizer(closeGestureRecognizer)
	}

	func closeLoansView() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
