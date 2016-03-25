//
//  RXInitialViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 25/03/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit
import DKHelper

class RXInitialViewController           : UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var loginButton      : UIButton?
    @IBOutlet weak var signUpButton     : UIButton?
    @IBOutlet weak var pageContainerView: UIView?
    
    // MARK: - Private properties
    private var pageViewController      : RXInitialPageViewController?
    private var pageTutorialText        : [String]? = []
    private var pageTutorialImages      : [String]? = []
    
    // MARK: - Lige cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        self.pageTutorialImages = ["dineroFacilTutorial.jpg", "prestamoTutorial.jpg", "rifaTutorial.jpg"]
        self.pageTutorialText = [L("Initial.Page.Tutorial.First.Text"), L("Initial.Page.Tutorial.Second.Text"), L("Initial.Page.Tutorial.Third.Text")]
        
        self.createPageViewController()
        self.configurateButtoons()
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
        if (self.pageTutorialText?.count == 0 ||
            self.pageTutorialImages?.count == 0 ||
            _index >= self.pageTutorialText?.count ||
            _index >= self.pageTutorialImages?.count ||
            _index < 0) {
                return nil
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(StoryboardIds.InitialPageContentViewController) as? RXInitialPageContentViewController
        pageContentViewController?.imageFile = self.pageTutorialImages?[_index]
        pageContentViewController?.tutorialText = self.pageTutorialText?[_index]
        pageContentViewController?.pageindex = _index
        
        return pageContentViewController
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
        return (self.pageTutorialText?.count ?? 0)
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
