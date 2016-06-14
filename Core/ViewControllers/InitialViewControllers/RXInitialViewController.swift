//
//  RXInitialViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 25/03/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit
import DKHelper

enum RXTutorial : Int {
    
    case EasyMoney = 0
    case Loan
    case Raffle
    
    static func allValues() -> [RXTutorial] {
        return [.EasyMoney, .Loan, .Raffle]
    }
    
    func image() -> String {
        switch self {
        case .EasyMoney:        return "dineroFacilTutorial.jpg"
        case .Loan:             return "prestamoTutorial.jpg"
        case .Raffle:           return "rifaTutorial.jpg"
        }
    }
    
    func text() -> String {
        switch self {
        case .EasyMoney:        return L("Initial.Page.Tutorial.First.Text")
        case .Loan:             return L("Initial.Page.Tutorial.Second.Text")
        case .Raffle:           return L("Initial.Page.Tutorial.Third.Text")
        }
    }
}

class RXInitialViewController                   : UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var loginButton      : UIButton?
    @IBOutlet private weak var signUpButton     : UIButton?

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateButtoons()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }

	// MARK: - Configurations
    
    /**
     Method to configurate buttons (login/ signup)
     */
    private func configurateButtoons() {
        self.loginButton?.setTitle(L("Initial.Page.Login.Button"), forState: .Normal)
        self.loginButton?.roundRect(radius: CornerRadius.StandardCornerRadius)
		self.loginButton?.backgroundColor = UIColor(fromHexString: "#392F54")
        self.signUpButton?.setTitle(L("Initial.Page.Register.Button"), forState: .Normal)
        self.signUpButton?.roundRect(radius: CornerRadius.StandardCornerRadius)
		self.signUpButton?.backgroundColor = UIColor(fromHexString: "#F39D5B")
    }
    
    // MARK: - Actions
    
    @IBAction func openLogin(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueIds.ToLoginViewController, sender: nil)
    }
    
    @IBAction func openSignIn(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueIds.ToSignUpViewController, sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == SegueIds.ToSignUpViewController) {
            let vc = segue.destinationViewController as? RXLoginSignUpViewController
            vc?.loginSignUpType = .SignUp
        }
    }
}