//
//  IndicatorPresenter.swift
//  VPNTest
//
//  Created by Dmitry Serebrov on 15.08.2023.
//

import Foundation
class IndicatorPresenter {
	private var view: IndicatorViewController
	private var indicatorServer: IndicatorServer
	private var prevUpload = CGFloat(0)
	init(view: IndicatorViewController, server: IndicatorServer){
		self.view = view
		self.indicatorServer = server
	}
	func getViewDataForSpeedTest() {
		getPingData()
		getUploadData()
	}
	
	func getPingData() {
		let viewDataPing = ViewModel.PingData(ping: String(self.indicatorServer.getPingData()))
		view.renderPing(viewData: viewDataPing)
	}
	
	func getUploadData() {
		var timerCounter = 0
		
		let viewData = ViewModel.UploadData(upload: "--", angle: -prevUpload)
		
		view.renderUpload(viewData: viewData)
		
		prevUpload = 0
		
		Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
			timerCounter += 1
			
			if timerCounter <= 30 {
				let upload = self.indicatorServer.getUploadData()
				let viewDataUpload = ViewModel.UploadData(upload: String(upload),
														  angle: CGFloat(upload)-self.prevUpload)
				self.view.renderUpload(viewData: viewDataUpload)
				
				self.prevUpload = CGFloat(upload)
				if timerCounter == 30 {
					let endViewData = ViewModel.UploadData(upload: String(upload), angle: -self.prevUpload)
					self.prevUpload = 0
					self.view.renderUpload(viewData: endViewData)
					
					let viewData = ViewModel.DownloadData(download: "--", angle: -self.prevUpload)
					
					self.view.renderDownload(viewData: viewData)
					
				}
			}
			
			if timerCounter > 30 && timerCounter <= 60 {
				
				
				let download = self.indicatorServer.getDownloadData()
				let viewDataDownload = ViewModel.DownloadData(download: String(download),
														  angle: CGFloat(download)-self.prevUpload)
				self.view.renderDownload(viewData: viewDataDownload)
				
				self.prevUpload = CGFloat(download)
				if timerCounter == 60 {
					let endViewData = ViewModel.DownloadData(download: String(download), angle: 0)
					self.view.renderDownload(viewData: endViewData)
					timer.invalidate()
				}
			}
			
			
			
		}
	}
}
