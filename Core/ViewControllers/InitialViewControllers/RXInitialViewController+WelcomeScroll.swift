//
//  RXInitialViewController+WelcomeScroll.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 14/06/16.
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
		case .EasyMoney:        return "Tutorial1"
		case .Loan:             return "Tutorial1"
		case .Raffle:           return "Tutorial1"
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

extension RXInitialViewController {

	/**
	Welcome Scrollview setup
	*/
	func scrollViewSetup() {

		self.pageControl?.numberOfPages = RXTutorial.allValues().count
		let scrollHeight = self.view.frameHeight
		let scrollWidth = self.view.frameWidth * CGFloat(RXTutorial.allValues().count)
		self.welcomeScrollView?.contentSize = CGSize(width: scrollWidth, height: scrollHeight)

		for index in (0..<RXTutorial.allValues().count) {

			if let
				_welcomeViewType = RXTutorial(rawValue: index),
				_welcomeView = RXWelcomeView.instanceFromNib() {
					var frame = (self.welcomeScrollView?.frame ?? CGRect.zero)
					frame.origin.x = (CGFloat(index) * frame.width)
					frame.origin.y = 0
					_welcomeView.frame = frame
					_welcomeView.welcomeImageView?.image = UIImage(named: _welcomeViewType.image())
					_welcomeView.titleLabel?.text = _welcomeViewType.text()
					self.welcomeScrollView?.addSubview(_welcomeView)
					if let _welcomeScrollView = self.welcomeScrollView {
						self.view.sendSubviewToBack(_welcomeScrollView)
					}
			}
		}
		self.welcomeScrollView?.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
	}
}

extension RXInitialViewController: UIScrollViewDelegate {

	func scrollViewDidScroll(scrollView: UIScrollView) {
		if (scrollView.frameWidth != 0) {
			let actualPage = Int(scrollView.contentOffset.x / scrollView.frameWidth)
			self.pageControl?.currentPage = actualPage
		}
	}
}
