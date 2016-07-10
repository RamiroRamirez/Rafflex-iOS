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
	case Or
    case ForgotPassword
    
    static func allValues() -> [LoginSignUpRow] {
        return [.Icon, .Facebook, .Or, .Email, .Password, .AgainPassword, .LoginSignup]
    }
    
    static func loginValues() -> [LoginSignUpRow] {
        return [.Icon, .Facebook, .Or, .Email, .Password, .LoginSignup, .ForgotPassword]
    }
    
    static func signUpValues() -> [LoginSignUpRow] {
        return [.Icon, .Facebook, .Or, .Email, .Password, .AgainPassword, .LoginSignup]
    }
    
    func reuseIdentifier() -> String {
        switch self {
        case .Icon:             return CellIdentifiers.LoginIconCell
        case .Email:            return CellIdentifiers.LoginInputCell
        case .Password:         return CellIdentifiers.LoginInputCell
        case .AgainPassword:    return CellIdentifiers.LoginInputCell
        case .LoginSignup:      return CellIdentifiers.LoginButtonCell
        case .Facebook:         return CellIdentifiers.LoginFacebook
		case .Or:               return CellIdentifiers.LoginOr
        case .ForgotPassword:   return CellIdentifiers.ForgotPassword
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
		case .Or:				return nil
        case .ForgotPassword:   return nil
        }
    }

	func imageForInputCell() -> String? {
		switch self {
		case .Icon:             return nil
		case .Email:            return "Mail"
		case .Password:         return "Lock"
		case .AgainPassword:    return "Lock"
		case .LoginSignup:      return nil
		case .Facebook:         return nil
		case .Or:				return nil
        case .ForgotPassword:   return nil
		}
	}

    func cellHeight() -> CGFloat {
        switch self {
        case .Icon:             return CellHeights.IconCell
        case .Email:            return CellHeights.InputCell
        case .Password:         return CellHeights.InputCell
        case .AgainPassword:    return CellHeights.InputCell
        case .LoginSignup:      return CellHeights.LoginButtonCell
        case .Facebook:         return CellHeights.FacebookCell
		case .Or:				return CellHeights.InputCell
        case .ForgotPassword:   return CellHeights.LoginButtonCell
        }
    }
}

class RXLoginSignUpCell                         	: UITableViewCell {
    
    var type                                    	: LoginSignUpRow?
    var loginSignupType                         	: LoginSignUpType?
    var executeLoginBlock                       	: (() -> Void)?
    var dismissBlock                                : (() -> Void)?
    var inputBlock                                  : ((parameterKey: String, value: String) -> Void)?
    
    func setCell() {
        // please override in subclasses
    }
}

class RXLoginForgotPassword                         : RXLoginSignUpCell {
    
    @IBOutlet private weak var forgotPasswordButton : UIButton?
    
    override func setCell() {
        super.setCell()
        self.forgotPasswordButton?.setTitle(L("Login.Label.ForgotPassword"), forState: .Normal)
    }
}

class RXLoginIconCell                           	: RXLoginSignUpCell {
    
    @IBOutlet private weak var iconImageView   	 	: UIImageView?
    @IBOutlet weak var closeButton                  : UIButton?
    
    override func setCell() {
        super.setCell()
    }
    
    // MARK: - Actions
    
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissBlock?()
    }
}

class RXLoginInputCell                          	: RXLoginSignUpCell {
    
    @IBOutlet private weak var inputTextField   	: UITextField?
	@IBOutlet private weak var inputImageView		: UIImageView?
    
    override func setCell() {
        super.setCell()
        self.inputTextField?.delegate = self
        if let _placeholder = self.type?.placeholder() {
            self.inputTextField?.attributedPlaceholder = NSAttributedString(string:_placeholder, attributes:[NSForegroundColorAttributeName: UIColor(white: 1.0, alpha: 0.4)])
        }
		if let _imageName = self.type?.imageForInputCell() {
			self.inputImageView?.image = UIImage(named: _imageName)
		}
    }
}

extension RXLoginInputCell                          : UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        let parameterKey = ((self.type == .Email) ? API.Parameter.Email.rawValue : API.Parameter.Password.rawValue)
        if let _textInTextField = textField.text {
            self.inputBlock?(parameterKey: parameterKey, value: _textInTextField)
        }
    }
}

class RXLoginButtonCell                         	: RXLoginSignUpCell {
    
    @IBOutlet private weak var loginButton      	: UIButton?

    override func setCell() {
        super.setCell()
        let buttonTitle = ((self.loginSignupType == .Login) ? L("Login.Button.Login") : L("Login.Button.SignUp"))
        self.loginButton?.setTitle(buttonTitle, forState: .Normal)
    }
    
    @IBAction func executeLogin(sender: AnyObject) {
        self.executeLoginBlock?()
    }
}

class RXLoginFacebook               				: RXLoginSignUpCell {
    
    @IBOutlet private weak var facebookLoginView 	: UIView?
    
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

class RXLoginOr										: RXLoginSignUpCell {

	@IBOutlet private weak var orLabel 				: UILabel?

	override func setCell() {
		super.setCell()
		self.orLabel?.text = L("Login.Or")
	}
}

// MARK: - Implementation FBSDKLoginButtonDelegate protocol

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
    var loginRegisterParameters     : [String: String]? = [:]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.setBackroungImage()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RXLoginSignUpViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }

    // MARK: - Private Methods
    
    private func loginSignupPressed() {
        self.view.endEditing(true)
		if (self.loginSignUpType == .Login),
            let
                _email = self.loginRegisterParameters?[API.Parameter.Email.rawValue],
                _password = self.loginRegisterParameters?[API.Parameter.Password.rawValue] {
                    let parameters = [API.Parameter.Email.rawValue: _email, API.Parameter.Password.rawValue: _password]
                    RXAPIManager.login(parameters, successBlock: { (result) in
                            self.performSegueWithIdentifier(SegueIds.ToMainMenuViewController, sender: nil)
                        }, failureBlock: { (result, error) in
                            self.performSegueWithIdentifier(SegueIds.ToMainMenuViewController, sender: nil)
                    })
        } else if (self.loginSignUpType == .SignUp) {
            
        }
    }
    
    private func receivedParametersForLoginRegister(parameterKey: String, value: String) {
        self.loginRegisterParameters?[parameterKey] = value
    }

	private func setBackroungImage() {
		let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
		backgroundImage.image = UIImage(named: "Splash")
		self.view.addSubview(backgroundImage)
		self.view.sendSubviewToBack(backgroundImage)
	}
    
    private func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
        cell.dismissBlock = self.dismissView
        cell.inputBlock = self.receivedParametersForLoginRegister
        cell.setCell()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let loginRow = ((self.loginSignUpType == .Login) ? LoginSignUpRow.loginValues()[indexPath.row] : LoginSignUpRow.signUpValues()[indexPath.row])
        return loginRow.cellHeight()
    }
}
