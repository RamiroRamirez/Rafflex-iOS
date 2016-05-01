//
//  RXRafflesViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXRafflesViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.addGestureRecgnizer()
	}

	private func addGestureRecgnizer() {

		let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.closeRafflesView))
		closeGestureRecognizer.direction = .Left
		closeGestureRecognizer.delaysTouchesBegan = true
		self.view.addGestureRecognizer(closeGestureRecognizer)
	}

	func closeRafflesView() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}


}
