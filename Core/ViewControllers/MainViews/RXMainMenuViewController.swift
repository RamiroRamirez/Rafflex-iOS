//
//  RXMainMenuViewController.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 19/04/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import UIKit

class RXMainMenuViewController              			: UIViewController {
    
    @IBOutlet weak var profileImageView     			: UIImageView?
	@IBOutlet weak var infoImageView					: UIImageView?
	@IBOutlet weak var promoImageView					: UIImageView?
	@IBOutlet weak var cloverImageView					: UIImageView?
	@IBOutlet weak var cloverHeightConstraint			: NSLayoutConstraint?
	@IBOutlet weak var cloverVerticalCenterConstraint	: NSLayoutConstraint?
	@IBOutlet weak var cloverWidthConstraint			: NSLayoutConstraint?

	@IBOutlet weak var arrowUpUpImageView				: RXArrowImageView?
	@IBOutlet weak var arrowUpMiddleImageView			: RXArrowImageView?
	@IBOutlet weak var arrowUpBottomImageView			: RXArrowImageView?
	@IBOutlet weak var arrowRightLeftImageView			: RXArrowImageView?
	@IBOutlet weak var arrowRightMiddleImageView		: RXArrowImageView?
	@IBOutlet weak var arrowRightRightImageView			: RXArrowImageView?
	@IBOutlet weak var arrowDownUpImageView				: RXArrowImageView?
	@IBOutlet weak var arrowDownMiddleImageView			: RXArrowImageView?
	@IBOutlet weak var arrowDownBottomImageView			: RXArrowImageView?

	@IBOutlet var arrowsCollection						: [RXArrowImageView]?

	var timerArrowAnimation								: NSTimer?
    
	// MARK: - Life Cycle Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		self.setArrowsState()
		self.hideBackButton()
        self.setBackroungImage()
        self.profileImageSettings()
		self.setGestureRecongnizers()
	}

	override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
		self.navigationController?.navigationBarHidden = false
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		if (self.timerArrowAnimation == nil) {
			self.showClover(AnimationConstants.FirstCloverMove, andDuration: AnimationConstants.StandarAnimationInterval)
		} else {
			self.changeSizeFromClover(size: AnimationConstants.LittleCloverWidthHeight)
		}
	}

	// MARK: - Private/ Configurations Methods

	private func setArrowsState() {

		self.arrowUpUpImageView?.state = .Full
		self.arrowUpMiddleImageView?.state = .Middle
		self.arrowUpBottomImageView?.state = .Light

		self.arrowRightLeftImageView?.state = .Light
		self.arrowRightMiddleImageView?.state = .Middle
		self.arrowRightRightImageView?.state = .Full

		self.arrowDownUpImageView?.state = .Light
		self.arrowDownMiddleImageView?.state = .Middle
		self.arrowDownBottomImageView?.state = .Full
	}
    
    private func setBackroungImage() {
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "Splash")
        self.view.addSubview(backgroundImage)
        self.view.sendSubviewToBack(backgroundImage)
    }
    
    private func profileImageSettings() {
        self.profileImageView?.layer.borderWidth = 2
        self.profileImageView?.layer.borderColor = UIColor.whiteColor().CGColor
        self.profileImageView?.layer.cornerRadius = 50
        self.profileImageView?.clipsToBounds = true
        
    }

	private func hideBackButton() {
		self.navigationItem.setHidesBackButton(true, animated: false)
	}

	private func setGestureRecongnizers() {

		let swipeCreateRaffle = UISwipeGestureRecognizer(target: self, action: #selector(self.takePartInRaffle))
		swipeCreateRaffle.direction = .Up
		self.view.addGestureRecognizer(swipeCreateRaffle)

		let swipeTakePartInRaffle = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.createRaffle))
		swipeTakePartInRaffle.direction = .Right
		self.view.addGestureRecognizer(swipeTakePartInRaffle)

		let swipeAskForALoan = UISwipeGestureRecognizer(target: self, action: #selector(RXMainMenuViewController.askForALoan))
		swipeAskForALoan.direction = .Down
		self.view.addGestureRecognizer(swipeAskForALoan)

	}

	// MARK: - Gesture recognizers methods
	
	func createRaffle() {
		self.navigationController?.navigationBarHidden = true
		self.performSegueWithIdentifier(SegueIds.ToCreateRaffle, sender: nil)
	}

	func takePartInRaffle() {
		self.performSegueWithIdentifier(SegueIds.ToRaffleViewController, sender: nil)
	}

	func askForALoan() {
		self.performSegueWithIdentifier(SegueIds.ToLoansViewController, sender: nil)
	}
    
    // MARK: - Actions
    
    @IBAction func profileButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier(SegueIds.ToProfileViewController, sender: nil)
    }
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func promotionButtonPressed(sender: AnyObject) {
        
    }
}

// MARK: - Animation

extension RXMainMenuViewController {

	enum AnimationState: Int {
		case Light = 0
		case Middle
		case Full

		static func allValues() -> [AnimationState] {
			return [.Light, .Middle, .Full]
		}

		func imageForState(forDirection direction: AnimationDirection) -> UIImage? {
			switch self {
			case .Light: 	return direction.imageForLightState()
			case .Middle: 	return direction.imageForLightState()
			case .Full:		return direction.imageForFullState()
			}
		}

		func nextState() -> AnimationState {
			switch self {
			case .Light:	return .Full
			case .Middle:	return .Light
			case .Full:		return .Middle
			}
		}
	}

	enum AnimationDirection {
		case Up
		case Right
		case Down

		func imageForLightState() -> UIImage? {
			switch self {
			case .Up:		return UIImage(named: "ic_arrowUpLight")
			case .Right:	return UIImage(named: "ic_arrowRightLight")
			case .Down:		return UIImage(named: "ic_arrowDownLight")
			}
		}

		func imageForFullState() -> UIImage? {
			switch self {
			case .Up:		return UIImage(named: "ic_arrowUp")
			case .Right:	return UIImage(named: "ic_arrowRight")
			case .Down:		return UIImage(named: "ic_arrowDown")
			}
		}
	}

	private func showClover(verticalCenterConstant: CGFloat, andDuration: NSTimeInterval) {
		self.cloverVerticalCenterConstraint?.constant = verticalCenterConstant
		UIView.animateWithDuration(andDuration, animations: {
			self.view.layoutIfNeeded()
			}, completion: { (animationDone: Bool) in
				if (verticalCenterConstant == AnimationConstants.FirstCloverMove) {
					self.showClover(AnimationConstants.SecondCloverMove, andDuration: AnimationConstants.StandarAnimationInterval)
				} else if (verticalCenterConstant == AnimationConstants.SecondCloverMove) {
					self.showClover(AnimationConstants.FinalCloverMove, andDuration: AnimationConstants.StandarAnimationInterval)
				} else if (verticalCenterConstant == AnimationConstants.FinalCloverMove) {
					self.rotateClover()
				}
		})

	}

	private func rotateClover() {
		UIView.animateWithDuration(AnimationConstants.RotateAnimationInterval, animations: {
			self.cloverImageView?.transform = CGAffineTransformMakeRotation((AnimationConstants.GradesToRotateClover * CGFloat(M_PI)) / 180.0)
			}, completion: { (animationDone: Bool) in
				self.changeSizeFromClover(size: AnimationConstants.LittleCloverWidthHeight)
		})
	}

	private func changeSizeFromClover(size size: CGFloat) {

		self.cloverHeightConstraint?.constant = size
		self.cloverWidthConstraint?.constant = size

		UIView.animateWithDuration(AnimationConstants.StandarAnimationInterval, animations: {
			self.view.layoutIfNeeded()
			}, completion: { (animationDone: Bool) in

				if (size == AnimationConstants.LittleCloverWidthHeight) {
					self.changeSizeFromClover(size: AnimationConstants.NormalCloverWidthHeight)

				} else {
					self.makeElementsVisible()
					if (self.timerArrowAnimation == nil) {
						self.timerArrowAnimation = NSTimer.scheduledTimerWithTimeInterval(AnimationConstants.StandarAnimationInterval, target: self, selector: #selector(self.changeArrowState), userInfo: nil, repeats: true)
					}
				}
		})
	}

	private func makeElementsVisible() {

		UIView.animateWithDuration(AnimationConstants.StandarAnimationInterval) {
			self.profileImageView?.alpha = 1.0
			self.infoImageView?.alpha = 1.0
			self.promoImageView?.alpha = 1.0

			for arrow in self.arrowsCollection ?? [] {
				arrow.alpha = 1.0
			}
		}
	}

	func changeArrowState() {
		self.arrowUpUpImageView?.state = (self.arrowUpUpImageView?.state)?.nextState()
		self.arrowUpMiddleImageView?.state = (self.arrowUpMiddleImageView?.state)?.nextState()
		self.arrowUpBottomImageView?.state = (self.arrowUpBottomImageView?.state)?.nextState()
		self.arrowRightLeftImageView?.state = (self.arrowRightLeftImageView?.state)?.nextState()
		self.arrowRightMiddleImageView?.state = (self.arrowRightMiddleImageView?.state)?.nextState()
		self.arrowRightRightImageView?.state = (self.arrowRightRightImageView?.state)?.nextState()
		self.arrowDownUpImageView?.state = (self.arrowDownUpImageView?.state)?.nextState()
		self.arrowDownMiddleImageView?.state = (self.arrowDownMiddleImageView?.state)?.nextState()
		self.arrowDownBottomImageView?.state = (self.arrowDownBottomImageView?.state)?.nextState()

		self.arrowUpUpImageView?.image = self.arrowUpUpImageView?.state?.imageForState(forDirection: .Up)
		self.arrowUpMiddleImageView?.image = self.arrowUpMiddleImageView?.state?.imageForState(forDirection: .Up)
		self.arrowUpBottomImageView?.image = self.arrowUpBottomImageView?.state?.imageForState(forDirection: .Up)

		self.arrowRightLeftImageView?.image = self.arrowRightLeftImageView?.state?.imageForState(forDirection: .Right)
		self.arrowRightMiddleImageView?.image = self.arrowRightMiddleImageView?.state?.imageForState(forDirection: .Right)
		self.arrowRightRightImageView?.image = self.arrowRightRightImageView?.state?.imageForState(forDirection: .Right)

		self.arrowDownUpImageView?.image = self.arrowDownUpImageView?.state?.imageForState(forDirection: .Down)
		self.arrowDownMiddleImageView?.image = self.arrowDownMiddleImageView?.state?.imageForState(forDirection: .Down)
		self.arrowDownBottomImageView?.image = self.arrowDownBottomImageView?.state?.imageForState(forDirection: .Down)
	}
}

class UIStoryboardSegueFromTop: UIStoryboardSegue {

	override func perform() {
		let src = self.sourceViewController as UIViewController
		let dst = self.destinationViewController as UIViewController

		src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
		dst.view.transform = CGAffineTransformMakeTranslation(0, -src.view.frame.size.height)

		UIView.animateWithDuration(AnimationConstants.StandarAnimationInterval, animations: {
			dst.view.transform = CGAffineTransformMakeTranslation(0, 0)
			}, completion: { (finished: Bool) in
			src.presentViewController(dst, animated: false, completion: nil)
		})
	}
}
