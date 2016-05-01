//
//  RXMainMenuViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXMainMenuViewController: UIViewController {

	// MARK: - Life Cycle Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideBackButton()
		self.setGestureRecongnizers()
	}

	override func viewWillAppear(animated: Bool) {
		self.navigationController?.navigationBarHidden = false
	}

	// MARK: - Private/ Configurations Methods

	private func hideBackButton() {
		self.navigationItem.setHidesBackButton(true, animated: false)
	}

	private func setGestureRecongnizers() {

		let swipeCreateRaffle = UISwipeGestureRecognizer(target: self, action: #selector(self.askForALoan))
		swipeCreateRaffle.direction = .Up
		self.view.addGestureRecognizer(swipeCreateRaffle)

		let swipeTakePartInRaffle = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.takePartInRaffle))
		swipeTakePartInRaffle.direction = .Right
		self.view.addGestureRecognizer(swipeTakePartInRaffle)

		let swipeAskForALoan = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.createRaffle))
		swipeAskForALoan.direction = .Down
		self.view.addGestureRecognizer(swipeAskForALoan)

	}

	// MARK: - Gesture recognizers methods
	
	func createRaffle() {
		self.navigationController?.navigationBarHidden = true
		self.performSegueWithIdentifier(SegueIds.ToCreateRaffle, sender: nil)
	}

	func takePartInRaffle() {
		self.performSegueWithIdentifier(SegueIds.ToRaffleViewController, sender: nil)
	}

	func askForALoan() {
		self.performSegueWithIdentifier(SegueIds.ToLoansViewController, sender: nil)
	}
}

class UIStoryboardSegueFromTop: UIStoryboardSegue {

	override func perform() {
		let src = self.sourceViewController as UIViewController
		let dst = self.destinationViewController as UIViewController

		src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
		dst.view.transform = CGAffineTransformMakeTranslation(0, -src.view.frame.size.height)

		UIView.animateWithDuration(0.3, animations: {
			dst.view.transform = CGAffineTransformMakeTranslation(0, 0)
			}, completion: { (finished: Bool) in
			src.presentViewController(dst, animated: false, completion: nil)
		})
	}
}
