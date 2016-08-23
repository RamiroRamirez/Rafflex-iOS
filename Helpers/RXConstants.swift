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
		case Register							= "register.php"
    }
    
    enum Parameter                              : String {
        
        case Email                              = "email"
        case Password                           = "pwd"
    }

	enum Keys									: String {

		case IdUser								= "id_user"
		case FirstName							= "first_name"
		case LastName							= "last_name"
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
	static let ToPersonalContainerView			= "toPersonalContainerView"
	static let ToPersonalDataViewController		= "toPersonalDataTableView"
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
	static let UserInfoCell						= "UserInfoCell"
	static let UserInfoInputCell				= "UserInputCell"
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

struct AnimationConstants {

	static let FirstCloverMove					: CGFloat = -80
	static let SecondCloverMove					: CGFloat = -40
	static let FinalCloverMove					: CGFloat = -60

	static let GradesToRotateClover				: CGFloat = 40
	static let NormalCloverWidthHeight			: CGFloat = 150
	static let LittleCloverWidthHeight			: CGFloat = 130

	static let StandarAnimationInterval			: NSTimeInterval = 0.3
	static let RotateAnimationInterval			: NSTimeInterval = 1.5
	
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
