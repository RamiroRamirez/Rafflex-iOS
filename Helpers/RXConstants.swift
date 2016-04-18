//
//  File.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 25/03/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

struct StoryboardIds {
    
    static let InitialPageViewController        = "RXInitialPageViewController"
    static let InitialPageContentViewController = "RXInitialPageContentViewController"
}

struct SegueIds {

    static let ToLoginViewController            = "toLoginViewController"
    static let ToSignUpViewController           = "toSignUpViewController"
}

struct CellIdentifiers {
    
    static let LoginIconCell                    = "LoginIconCell"
    static let LoginInputCell                   = "LoginInputCell"
    static let LoginButtonCell                  = "LoginButtonCell"
    static let LoginFacebook                    = "LoginFacebookCell"
}

struct CellHeights {
    static let IconCell: CGFloat                = 210
    static let InputCell: CGFloat               = 44
    static let FacebookCell: CGFloat            = 54
}

struct CornerRadius {
    
    static let StandardCornerRadius : CGFloat   = 5.0
}

struct FacebookSDK {
    
    static let Email                            = "email"
    static let PublicProfile                    = "public_profile"
    static let Me                               = "me"
    static let Fields                           = "fields"
    static let NameEmail                        = "name, email"
}
