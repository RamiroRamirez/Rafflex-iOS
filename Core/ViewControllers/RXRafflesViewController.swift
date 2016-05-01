//
//  RXRafflesViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXRafflesViewController		: UIViewController {

	// MARK: - IBOutlets

	@IBOutlet weak var tableView	: UITableView?

	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView?.delegate = self
		self.tableView?.dataSource = self
		self.addGestureRecgnizer()
	}

	private func addGestureRecgnizer() {

		let closeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.closeRafflesView))
		closeGestureRecognizer.direction = .Down
		closeGestureRecognizer.delaysTouchesBegan = true
		self.tableView?.addGestureRecognizer(closeGestureRecognizer)
	}

	@IBAction func dismissView(sender: AnyObject) {

		self.closeRafflesView()
	}

	func closeRafflesView() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}

extension RXRafflesViewController				: UITableViewDelegate, UITableViewDataSource {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.RaffleCategoryCell) as? RXCategoryCell else {
			return UITableViewCell()
		}
		cell.categoryTitleLabel?.text = "Rifas por categoria"
		cell.setCell()
		return cell
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 210
	}
}

class RXCategoryCell							: UITableViewCell {

	@IBOutlet weak var categoryTitleLabel		: UILabel?
	@IBOutlet weak var raffleCollectionView		: RXRaffleCollectionView?

	override func awakeFromNib() {
		self.raffleCollectionView?.delegate = self
		self.raffleCollectionView?.dataSource = self
	}

	func setCell() {

	}
}

extension RXCategoryCell						: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifiers.RaffleGroupCell, forIndexPath: indexPath) as? RXRaffleCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.raffleGroupLabel?.text = "Algo"
		return cell
	}
}

class RXRaffleCollectionView					: UICollectionView {

	override func awakeFromNib() {
		self.backgroundColor = UIColor.whiteColor()
	}
}

class RXRaffleCollectionViewCell				: UICollectionViewCell {
	
	@IBOutlet weak var raffleGroupLabel			: UILabel?
	@IBOutlet weak var raffleGroupImageView		: UIImageView?

	func setCollectionCell() {

	}
}
