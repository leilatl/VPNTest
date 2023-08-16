//
//  IndicatorServer.swift
//  VPNTest
//
//  Created by Dmitry Serebrov on 15.08.2023.
//

import Foundation
class IndicatorServer {
	func getIndicatorData() -> Indicator {
		let upload = Int.random(in: 1...200)
		return Indicator(ping: Int.random(in: 1...100),
						 upload: upload,
						 download: upload+17)
	}
	
	func getPingData() -> Int {
		Int.random(in: 1...100)
	}
	
	func getUploadData() -> Int {
		Int.random(in: 1...200)
	}
	
	func getDownloadData() -> Int {
		Int.random(in: 1...200)
	}
}
