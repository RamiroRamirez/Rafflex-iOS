//
//  RXPromosViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 17/07/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXPromosViewController			: UIViewController {

	@IBOutlet weak var tableView		: UITableView?

	// MARK: - Actions

	@IBAction func dismissViewController(sender: AnyObject) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}

extension RXPromosViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}