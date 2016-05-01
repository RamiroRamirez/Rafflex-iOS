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

	// MARK: - Private Methods

	private func hideBackButton() {
		self.navigationItem.setHidesBackButton(true, animated: false)
	}

	private func setGestureRecongnizers() {

		let swipeCreateRaffle = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.createRaffle))
		swipeCreateRaffle.direction = .Up
		self.view.addGestureRecognizer(swipeCreateRaffle)

		let swipeTakePartInRaffle = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.takePartInRaffle))
		swipeTakePartInRaffle.direction = .Right
		self.view.addGestureRecognizer(swipeTakePartInRaffle)

		let swipeAskForALoan = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.askForALoan))
		swipeAskForALoan.direction = .Down
		self.view.addGestureRecognizer(swipeAskForALoan)

	}

	func createRaffle() {
		self.performSegueWithIdentifier(SegueIds.ToCreateRaffle, sender: nil)
	}

	func takePartInRaffle() {
		self.performSegueWithIdentifier(SegueIds.ToRaffleViewController, sender: nil)
	}

	func askForALoan() {
		self.performSegueWithIdentifier(SegueIds.ToLoansViewController, sender: nil)
	}

}
