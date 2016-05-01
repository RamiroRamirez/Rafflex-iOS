//
//  RXLoginSignUpViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 28/03/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit
import DKHelper
import FBSDKCoreKit
import FBSDKLoginKit
import MBProgressHUD

enum LoginSignUpType: Int {
    case Login = 0
    case SignUp
}

enum LoginSignUpRow: Int {
    
    case Icon = 0
    case Email
    case Password
    case AgainPassword
    case LoginSignup
    case Facebook
    
    static func allValues() -> [LoginSignUpRow] {
        return [.Icon, .Email, .Password, .AgainPassword, .LoginSignup, .Facebook]
    }
    
    static func loginValues() -> [LoginSignUpRow] {
        return [.Icon, .Email, .Password, .LoginSignup, .Facebook]
    }
    
    static func signUpValues() -> [LoginSignUpRow] {
        return [.Icon, .Email, .Password, .AgainPassword, .LoginSignup, .Facebook]
    }
    
    func reuseIdentifier() -> String {
        switch self {
        case .Icon:         return CellIdentifiers.LoginIconCell
        case .Email:        return CellIdentifiers.LoginInputCell
        case .Password:     return CellIdentifiers.LoginInputCell
        case .AgainPassword:return CellIdentifiers.LoginInputCell
        case .LoginSignup:  return CellIdentifiers.LoginButtonCell
        case .Facebook:     return CellIdentifiers.LoginFacebook
        }
    }
    
    func placeholder() -> String? {
        switch self {
        case .Icon:             return nil
        case .Email:            return L("Login.Placeholder.Email")
        case .Password:         return L("Login.Placeholder.Password")
        case .AgainPassword:    return L("Login.Placeholder.PasswordConfirm")
        case .LoginSignup:      return nil
        case .Facebook:         return nil
        }
    }
    
    func cellHeight() -> CGFloat {
        switch self {
        case .Icon:             return CellHeights.IconCell
        case .Email:            return CellHeights.InputCell
        case .Password:         return CellHeights.InputCell
        case .AgainPassword:    return CellHeights.InputCell
        case .LoginSignup:      return CellHeights.InputCell
        case .Facebook:         return CellHeights.FacebookCell
        }
    }
}

class RXLoginSignUpCell                         : UITableViewCell {
    
    var type                                    : LoginSignUpRow?
    var loginSignupType                         : LoginSignUpType?
    var executeLoginBlock                       : (() -> Void)?
    
    func setCell() {
        // please override in subclasses
    }
}

class RXLoginIconCell                           : RXLoginSignUpCell {
    
    @IBOutlet private weak var iconImageView    : UIImageView?
    
    override func setCell() {
        super.setCell()
        // TODO: Put the icon of the app
//        self.iconImageView?.image = UIImage()
    }
}

class RXLoginInputCell                          : RXLoginSignUpCell {
    
    @IBOutlet private weak var inputTextField   : UITextField?
    
    override func setCell() {
        super.setCell()
        self.inputTextField?.placeholder = self.type?.placeholder()
    }
}

class RXLoginButtonCell                         : RXLoginSignUpCell {
    
    @IBOutlet private weak var loginButton      : UIButton?
    
    override func setCell() {
        super.setCell()
        let buttonTitle = ((self.loginSignupType == .Login) ? L("Login.Button.Login") : L("Login.Button.SignUp"))
        self.loginButton?.setTitle(buttonTitle, forState: .Normal)
    }
    
    @IBAction func executeLogin(sender: AnyObject) {
        self.executeLoginBlock?()
    }
}

class RXLoginFacebook               : RXLoginSignUpCell {
    
    @IBOutlet private weak var facebookLoginView : UIView?
    
    override func setCell() {
        super.setCell()
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = [FacebookSDK.Email, FacebookSDK.PublicProfile]
        loginButton.delegate = self
        loginButton.center = (self.facebookLoginView?.center ?? CGPoint.zero)
        self.facebookLoginView?.addSubview(loginButton)
        loginButton.matchParentConstraints()
    }
}

extension RXLoginFacebook: FBSDKLoginButtonDelegate {
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let facebookRequest = FBSDKGraphRequest(graphPath: FacebookSDK.Me, parameters: [FacebookSDK.Fields:FacebookSDK.NameEmail])
        facebookRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) in
            // TODO: Execute login with facebook infos
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
}

class RXLoginSignUpViewController   : UITableViewController {

    var loginSignUpType             : LoginSignUpType? = .Login
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RXLoginSignUpViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func loginSignupPressed() {
		if (self.loginSignUpType == .Login) {
        	self.performSegueWithIdentifier(SegueIds.ToMainMenuViewController, sender: nil)
		}
    }
}

// MARK: - Implementation TableViewDataSource/TableViewDelegate Protocols

extension RXLoginSignUpViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.loginSignUpType == .Login) {
            return LoginSignUpRow.loginValues().count
        } else if (self.loginSignUpType == .SignUp) {
            return LoginSignUpRow.signUpValues().count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let loginRow = ((self.loginSignUpType == .Login) ? LoginSignUpRow.loginValues()[indexPath.row] : LoginSignUpRow.signUpValues()[indexPath.row])
        guard let cell = tableView.dequeueReusableCellWithIdentifier(loginRow.reuseIdentifier()) as? RXLoginSignUpCell else {
            return UITableViewCell()
        }
        cell.type = loginRow
        cell.loginSignupType = self.loginSignUpType
        cell.executeLoginBlock = self.loginSignupPressed
        cell.setCell()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let loginRow = ((self.loginSignUpType == .Login) ? LoginSignUpRow.loginValues()[indexPath.row] : LoginSignUpRow.signUpValues()[indexPath.row])
        return loginRow.cellHeight()
    }
}
