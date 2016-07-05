//
//  HDWelcomeView.swift
//  HiDrive
//
//  Created by Ramiro Ramirez on 06/06/16.
//  Copyright © 2016 Smart Mobile Factory. All rights reserved.
//

import UIKit
import DKHelper

class RXWelcomeView							: UIView {

	// MARK: Outlets

	@IBOutlet weak var welcomeImageView		: UIImageView?
	@IBOutlet weak var titleLabel			: UILabel?

	class func instanceFromNib() -> RXWelcomeView? {
		return RXWelcomeView.loadFromNib(XibFiles.WelcomeView)
	}
}
