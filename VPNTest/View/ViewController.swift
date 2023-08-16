//
//  ViewController.swift
//  VPNTest
//
//  Created by Dmitry Serebrov on 15.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
	let speedTestLabel = UILabel()
	let starsView = UIImageView(image: StaticImages.starsBackground)
	let slider = UIImageView(image: StaticImages.sliderNums)
	let pingText = UIElementsFactory.indicatorTextLabel(text: StaticStrings.pingText)
	let downloadText = UIElementsFactory.indicatorTextLabel(text: StaticStrings.downloadText)
	let uploadText = UIElementsFactory.indicatorTextLabel(text: StaticStrings.uploadText)
	let indicatorsStackView = UIStackView()
	let pingIndicator = UIElementsFactory.indicatorDigitLabel()
	let uploadIndicator = UIElementsFactory.indicatorDigitLabel()
	let downloadIndicator = UIElementsFactory.indicatorDigitLabel()
	let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: StaticDigits.startButtonWidth, height: StaticDigits.startButtonHeight))
	let arrow = UIImageView(image: StaticImages.arrow)
	
	var prevRandom = CGFloat(0)
	var timer = Timer()
	private var presenter: IndicatorPresenter!

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter = IndicatorPresenter(view: self, server: IndicatorServer())
		style()
		layout()
	}
	
	@objc func startButtonAction() {
		downloadIndicator.text = StaticStrings.defaultDigitText
		uploadIndicator.text = StaticStrings.defaultDigitText
		presenter.getViewDataForSpeedTest()
	}
	
	private func rotateImageView(vectorIndicator: CGFloat) {
		UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
				self.arrow.transform = self.arrow.transform.rotated(by: .pi * vectorIndicator/200)
			})
		}
	
	private func style() {
		
		self.view.backgroundColor = StaticColors.backgroundColor
		
		speedTestLabel.textColor = .white
		speedTestLabel.font = StaticFonts.indicatorTitleFont
		speedTestLabel.text = StaticStrings.speedTestLabelText
		
		startButton.backgroundColor = .clear
		startButton.layer.cornerRadius = StaticDigits.startButtonCornerRadius
		startButton.layer.borderWidth = StaticDigits.startButtonBorderWidth
		startButton.layer.borderColor = UIColor.white.cgColor
		startButton.setTitle(StaticStrings.startButtonText, for: .normal)
		startButton.titleLabel?.font = StaticFonts.startButtonFont
		startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
		
	}
	
	private func layout() {
		let pingStackView = UIStackView(arrangedSubviews: [pingText, pingIndicator])
		pingStackView.axis = .vertical
		pingStackView.alignment = .center
		pingStackView.setCustomSpacing(StaticDigits.spacingIndicatorStackView, after: pingText)
		
		let uploadStackView = UIStackView(arrangedSubviews: [uploadText, uploadIndicator])
		uploadStackView.axis = .vertical
		uploadStackView.alignment = .center
		uploadStackView.distribution = .equalSpacing
		uploadStackView.setCustomSpacing(StaticDigits.spacingIndicatorStackView, after: uploadText)
		
		let downloadStackView = UIStackView(arrangedSubviews: [downloadText, downloadIndicator])
		downloadStackView.axis = .vertical
		downloadStackView.alignment = .center
		downloadStackView.distribution = .equalSpacing
		downloadStackView.setCustomSpacing(StaticDigits.spacingIndicatorStackView, after: downloadText)
		
		indicatorsStackView.addArrangedSubview(pingStackView)
		indicatorsStackView.addArrangedSubview(uploadStackView)
		indicatorsStackView.addArrangedSubview(downloadStackView)
		indicatorsStackView.distribution = .equalSpacing
		indicatorsStackView.axis = .horizontal
		indicatorsStackView.alignment = .center
		
		
		
		view.addSubview(starsView)
		starsView.addSubview(slider)
		starsView.addSubview(indicatorsStackView)
		starsView.addSubview(speedTestLabel)
		
		starsView.addSubview(arrow)
		
		view.addSubview(startButton)
		
		startButton.snp.makeConstraints { make in
			make.height.equalTo(StaticDigits.startButtonHeight)
			make.width.equalTo(StaticDigits.startButtonWidth)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().inset(StaticDigits.topBottomInsets)
		}
		
		starsView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		speedTestLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().inset(StaticDigits.topBottomInsets)
		}
		
		slider.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		indicatorsStackView.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(StaticDigits.stackViewSideInsets)
			make.right.equalToSuperview().inset(StaticDigits.stackViewSideInsets)
			make.centerX.equalToSuperview()
			make.top.equalTo(slider.snp_bottomMargin).inset(-StaticDigits.stackViewTopInset)
		}
		
		arrow.layer.anchorPoint =  CGPoint(x: 1, y: 0.5)

		arrow.snp.makeConstraints { make in
			make.centerX.equalTo(slider.snp_centerXWithinMargins)
			make.width.equalTo(StaticDigits.arrowHeight)
			make.height.equalTo(StaticDigits.arrowWidth)
			make.bottom.equalTo(slider.snp_bottomMargin).inset(-10)
			
		}
		
		
	}
}

extension ViewController: IndicatorViewController {
	
	
	func renderPing(viewData: ViewModel.PingData) {
		self.pingIndicator.text = viewData.ping
	}
	
	func renderUpload(viewData: ViewModel.UploadData) {
		rotateImageView(vectorIndicator: viewData.angle)
		self.uploadIndicator.text = viewData.upload
	}
	func renderDownload(viewData: ViewModel.DownloadData) {
		rotateImageView(vectorIndicator: viewData.angle)
		self.downloadIndicator.text = viewData.download
	}
}

protocol IndicatorViewController {
	func renderPing(viewData: ViewModel.PingData)
	func renderUpload(viewData: ViewModel.UploadData)
	func renderDownload(viewData: ViewModel.DownloadData)
}
