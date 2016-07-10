//
//  File.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 25/03/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

enum UserDefault                                : String {
    // Keys set in PList files
    case APIBaseURL                             = "ApiBaseURL"
}

struct API {
    
    enum Endpoint                               : String {
        
        case Login                              = "login.php"
    }
    
    enum Parameter                              : String {
        
        case Email                              = "email"
        case Password                           = "pwd"
    }
}

struct StoryboardIds {
    
    static let InitialPageViewController        = "RXInitialPageViewController"
    static let InitialPageContentViewController = "RXInitialPageContentViewController"
}

struct SegueIds {

    static let ToLoginViewController            = "toLoginViewController"
    static let ToSignUpViewController           = "toSignUpViewController"
    static let ToProfileViewController          = "toProfileViewController"
	static let ToMainMenuViewController			= "toMainMenu"
	static let ToCreateRaffle					= "toCreateRaffle"
	static let ToRaffleViewController			= "toRafflesViewController"
	static let ToLoansViewController			= "toAskForALoan"
}

struct CellIdentifiers {
    
    static let LoginIconCell                    = "LoginIconCell"
    static let ProfileImageCell                 = "ProfileImageCell"
    static let ProfileInfoCell                  = "ProfileInfoCell"
    static let LoginInputCell                   = "LoginInputCell"
    static let LoginButtonCell                  = "LoginButtonCell"
    static let LoginFacebook                    = "LoginFacebookCell"
	static let LoginOr							= "LoginOr"
    static let ForgotPassword                   = "ForgotPasswordCell"
	static let RaffleCategoryCell				= "CategoryCell"
	static let RaffleGroupCell					= "GroupCell"
}

struct CellHeights {
    static let IconCell                         : CGFloat = 210
    static let InputCell                        : CGFloat = 44
    static let LoginButtonCell                  : CGFloat = 70
    static let FacebookCell                     : CGFloat = 54
    static let RaffleCell                       : CGFloat = 210
    static let ProfileImageCell                 : CGFloat = 200
    static let ProfileCell                      : CGFloat = 55
}

struct CornerRadius {
    
    static let StandardCornerRadius 			: CGFloat = 5.0
}

struct XibFiles {
	static let WelcomeView						= "RXWelcomeView"
}

struct FacebookSDK {
    
    static let Email                            = "email"
    static let PublicProfile                    = "public_profile"
    static let Me                               = "me"
    static let Fields                           = "fields"
    static let NameEmail                        = "name, email"
}
