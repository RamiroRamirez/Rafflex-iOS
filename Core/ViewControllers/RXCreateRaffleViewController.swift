//
//  RXCreateRaffleViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXCreateRaffleViewController: UIViewController {

	// MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.addGestureRecgnizer()
	}

	private func addGestureRecgnizer() {

		let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.closeCreateRaffleView))
		closeGestureRecognizer.direction = .Up
		closeGestureRecognizer.delaysTouchesBegan = true
		self.view.addGestureRecognizer(closeGestureRecognizer)
	}

	func closeCreateRaffleView() {
		self.view.window?.backgroundColor = UIColor.whiteColor()
		UIView.animateWithDuration(0.3, animations: {
			self.view.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height)
			}, completion: { (finished: Bool) in
				self.dismissViewControllerAnimated(true, completion: nil)
		})
	}
}
