//
//  UIHelpers.swift
//  VPNTest
//
//  Created by Dmitry Serebrov on 15.08.2023.
//

import Foundation
import UIKit

struct StaticStrings {
	static let petronaFont = "Petrona-Regular"
	static let pingText = "Ping"
	static let downloadText = "Download"
	static let uploadText = "Upload"
	static let defaultDigitText = "--"
	static let speedTestLabelText = "Speed Test"
	static let startButtonText = "START"
}

struct StaticImages {
	static let starsBackground = UIImage(named: "stars")
	static let sliderNums = UIImage(named: "slider nums")
	static let arrow = UIImage(named: "Vector") //
}

struct StaticDigits {
	static let startButtonWidth = 146
	static let startButtonHeight = 48
	static let startButtonCornerRadius = CGFloat(4)
	static let startButtonBorderWidth = CGFloat(1)
	
	static let indicatorTextFontSize = CGFloat(12)
	
	static let spacingIndicatorStackView = CGFloat(4)
	
	static let topBottomInsets = CGFloat(60)
	
	static let stackViewSideInsets = CGFloat(70)
	static let stackViewTopInset = CGFloat(30)
	
	static let arrowHeight = CGFloat(150)
	static let arrowWidth = CGFloat(10)
}

struct StaticColors {
	static let backgroundColor = UIColor(named: "background")
	static let transparentWhite = UIColor(named: "TransparentWhite")
}

struct StaticFonts {
	static let indicatorTextFonts = UIFont(name: StaticStrings.petronaFont, size: StaticDigits.indicatorTextFontSize)
	static let indicatorDigitsFonts = UIFont(name: "PathwayGothicOne-Regular", size: 26)
	static let indicatorTitleFont = UIFont(name: "PathwayGothicOne-Regular", size: 32)
	static let startButtonFont = UIFont(name: "PathwayGothicOne-Regular", size: 36)
}

class UIElementsFactory {
	static func indicatorTextLabel(text: String) -> UILabel {
		let label = UILabel()
		label.font = StaticFonts.indicatorTextFonts
		label.text = text
		label.textColor = StaticColors.transparentWhite
		return label
	}
	
	static func indicatorDigitLabel() -> UILabel {
		let label = UILabel()
		label.font = StaticFonts.indicatorDigitsFonts
		label.text = StaticStrings.defaultDigitText
		label.textColor = .white
		return label
	}
}
