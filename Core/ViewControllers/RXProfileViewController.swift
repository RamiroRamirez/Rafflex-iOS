//
//  RXProfileViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 10/07/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit
import DKHelper

enum ProfileCell: Int {
    
    case Profile = 0
    case PersonalInformation
    case CreatedRafflex
    case BoughtRafflex
    case PaymentMethods
    
    static func allValues() -> [ProfileCell] {
        return [.Profile, .PersonalInformation, .CreatedRafflex, .BoughtRafflex, .PaymentMethods]
    }
    
    func reusableForCell() -> String {
        switch self {
        case .Profile:              return CellIdentifiers.ProfileImageCell
        case .PersonalInformation:  return CellIdentifiers.ProfileInfoCell
        case .CreatedRafflex:       return CellIdentifiers.ProfileInfoCell
        case .BoughtRafflex:        return CellIdentifiers.ProfileInfoCell
        case .PaymentMethods:       return CellIdentifiers.ProfileInfoCell
        }
    }
    
    func textToShow() -> String? {
        switch self {
        case .Profile:              return nil
        case .PersonalInformation:  return L("Profile.PersonalInformation")
        case .CreatedRafflex:       return L("Profile.CreatedRaffles")
        case .BoughtRafflex:        return L("Profile.BoughtTickets")
        case .PaymentMethods:       return L("Profile.PaymentMethods")
        }
    }
    
    func iconToShow() -> String {
        switch self {
        case .Profile:              return ""
        case .PersonalInformation:  return "ic_personalInfos"
        case .CreatedRafflex:       return "ic_createdRafflex"
        case .BoughtRafflex:        return "ic_boughtRafflex"
        case .PaymentMethods:       return "ic_paymentMethods"
        }
    }
    
    func heightOfRows() -> CGFloat {
        switch self {
        case .Profile:              return CellHeights.ProfileImageCell
        case .PersonalInformation:  return CellHeights.ProfileCell
        case .CreatedRafflex:       return CellHeights.ProfileCell
        case .BoughtRafflex:        return CellHeights.ProfileCell
        case .PaymentMethods:       return CellHeights.ProfileCell
        }
    }
}



class RXProfileCell                     : UITableViewCell {
    
    var cellType                        : ProfileCell?
    
    func setCell() {
        
    }
}

class RXProfileImageCell                : RXProfileCell {
    
    @IBOutlet weak var profileImageView : UIImageView?
    @IBOutlet weak var editButton       : UIButton?
    
    override func setCell() {
        super.setCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.profileImageView?.layer.cornerRadius = 57.5
        self.profileImageView?.clipsToBounds = true
    }
    
    @IBAction func editPressed(sender: AnyObject) {
        
    }
}

class RXProfileInfo                     : RXProfileCell {
    
    @IBOutlet weak var iconImageView    : UIImageView?
    @IBOutlet weak var infoLabel        : UILabel?
    
    override func setCell() {
        super.setCell()
        self.iconImageView?.image = UIImage(named: self.cellType?.iconToShow() ?? "")
        self.infoLabel?.text = self.cellType?.textToShow()
    }
}

class RXProfileViewController           : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func dismissButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension RXProfileViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileCell.allValues().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellType = ProfileCell.allValues()[indexPath.row]
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellType.reusableForCell()) as? RXProfileCell else {
            return UITableViewCell()
        }
        cell.cellType = cellType
        cell.setCell()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ProfileCell.allValues()[indexPath.row].heightOfRows()
    }
}
