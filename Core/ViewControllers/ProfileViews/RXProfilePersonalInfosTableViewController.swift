//
//  RXProfilePersonalInfosTableViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 29/07/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit
import DKHelper

enum PersonalInfosType: Int {

	case PersonalData = 0
	case AddressData
}

enum PersonalDataCell: Int {

	case FullName = 0
	case FullNameInput
	case CelularNumber
	case CelularNunmberInput
	case Birthday
	case BirthdayInput

	static func allValues() -> [PersonalDataCell] {
		return [.FullName, .FullNameInput, .CelularNumber, .CelularNunmberInput, .Birthday, .BirthdayInput]
	}

	func title() -> String? {
		switch self {
		case .FullName: 			return L("Profile.PersonalInformation.Name")
		case .FullNameInput:		return nil
		case .CelularNumber:		return L("Profile.PersonalInformation.Handy")
		case .CelularNunmberInput:	return nil
		case .Birthday:				return L("Profile.PersonalInformation.Birthday")
		case .BirthdayInput:		return nil
		}
	}

	func cellIdentifier() -> String {
		switch self {
		case .FullName, CelularNumber, .Birthday:					return CellIdentifiers.UserInfoCell
		case .FullNameInput, .CelularNunmberInput, .BirthdayInput:	return CellIdentifiers.UserInfoInputCell
		}
	}
}

enum AddressDataCell: Int {

	case Street = 0
	case StreetInput
	case Place
	case PlaceInput
	case PostalCode
	case PostalCodeInput
	case ExtraReferences
	case ExtraReferencesInput

	static func allValues() -> [AddressDataCell] {
		return [.Street, .Place, .PostalCode, .ExtraReferences]
	}

	func title() -> String? {
		switch self {
		case .Street:				return L("")
		case .StreetInput:			return nil
		case .Place:				return L("")
		case .PlaceInput:			return nil
		case .PostalCode:			return L("")
		case .PostalCodeInput:		return nil
		case .ExtraReferences:		return L("")
		case .ExtraReferencesInput:	return nil
		}
	}
}

class RXProfilePersonalInfosTableViewController		: UITableViewController {

	// MARK: - Properties

	var personalInfosType							: PersonalInfosType = .PersonalData

	// MARK: - Helpers

	private func cellForPersonalDataSection() {
		
	}

}

extension RXProfilePersonalInfosTableViewController {

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ((self.personalInfosType == .PersonalData) ? PersonalDataCell.allValues().count : AddressDataCell.allValues().count)
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
