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
    @IBOutlet private weak var pageContainerView: UIView?
    
    // MARK: - Private properties
    private var pageViewController              : RXInitialPageViewController?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createPageViewController()
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
    
    /**
     Method to create page controller
     */
    private func createPageViewController() {

        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIds.InitialPageViewController) as? RXInitialPageViewController
        self.pageViewController?.dataSource = self
        
        if let
            startViewController = self.viewControllerForIndex(0),
            pageViewController = self.pageViewController {
                let viewControllersForPage = [startViewController]
                self.pageViewController?.setViewControllers(viewControllersForPage, direction: .Forward, animated: true, completion: nil)
            self.pageContainerView?.addSubview(pageViewController.view)
            pageViewController.view.matchParentConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     Method to configurate buttons (login/ signup)
     */
    private func configurateButtoons() {
        self.loginButton?.setTitle(L("Initial.Page.Login.Button"), forState: .Normal)
        self.loginButton?.roundRect(radius: CornerRadius.StandardCornerRadius)
        self.signUpButton?.setTitle(L("Initial.Page.Register.Button"), forState: .Normal)
        self.signUpButton?.roundRect(radius: CornerRadius.StandardCornerRadius)
    }
    
    /**
     Method to create containers for page controller
     
     - parameter index: Int
     
     - returns: RXInitialPageContentViewController
     */
    private func viewControllerForIndex(index: Int?) -> RXInitialPageContentViewController? {
        guard let _index = index else {
            return nil
        }
        if (RXTutorial.allValues().count == 0 ||
            _index >= RXTutorial.allValues().count ||
            _index < 0) {
                return nil
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIds.InitialPageContentViewController) as? RXInitialPageContentViewController
        pageContentViewController?.imageFile = RXTutorial(rawValue: _index)?.image()
        pageContentViewController?.tutorialText = RXTutorial(rawValue: _index)?.text()
        pageContentViewController?.pageindex = _index
        
        return pageContentViewController
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

extension RXInitialViewController       : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController:UIViewController) -> UIViewController? {
        
        if let _index = (viewController as? RXInitialPageContentViewController)?.pageindex {
            var index = _index
            index = index - 1
            return self.viewControllerForIndex(index)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let _index = (viewController as? RXInitialPageContentViewController)?.pageindex {
            var index = _index
            index = index + 1
            return self.viewControllerForIndex(index)
        }
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return RXTutorial.allValues().count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
