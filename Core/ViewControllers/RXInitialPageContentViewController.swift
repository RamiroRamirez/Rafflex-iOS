//
//  RXInitialPageContentViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 25/03/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXInitialPageContentViewController    : UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var tutorialImageView    : UIImageView?
    @IBOutlet private weak var tutorialLabel        : UILabel?
    
    // MARK: - Public properties
    
    var pageindex                           : Int?
    var tutorialText                        : String?
    var imageFile                           : String?
    
    // MARK - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background image and tutorial text
        if let _imageFile = self.imageFile {
            self.tutorialImageView?.image = UIImage(named: _imageFile)
        }
        self.tutorialLabel?.text = self.tutorialText
    }
}
