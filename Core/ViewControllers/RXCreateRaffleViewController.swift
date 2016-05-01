//
//  RXCreateRaffleViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXCreateRaffleViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.addGestureRecgnizer()
	}

	private func addGestureRecgnizer() {

		let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.closeCreateRaffleView))
		closeGestureRecognizer.direction = .Down
		closeGestureRecognizer.delaysTouchesBegan = true
		self.view.addGestureRecognizer(closeGestureRecognizer)
	}

	func closeCreateRaffleView() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

}
