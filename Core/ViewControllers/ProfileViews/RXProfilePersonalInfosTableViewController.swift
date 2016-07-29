//
//  RXProfilePersonalInfosTableViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 29/07/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

enum PersonalInfosType: Int {

	case PersonalData = 0
	case AddressData
}

class RXProfilePersonalInfosTableViewController	: UITableViewController {

	// MARK: - Properties

	var personalInfosType						: PersonalInfosType = .PersonalData


}
