//
//  RXErrorHandler.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 23/08/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

struct RXErrorHandler {

	static func showErrorAlert(inViewController viewController: UIViewController?, title: String?, message: String?) {
		let errorAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
		errorAlertController.addAction(okAction)
		viewController?.presentViewController(errorAlertController, animated: true, completion: nil)
	}
}
