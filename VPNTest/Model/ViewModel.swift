//
//  ViewModel.swift
//  VPNTest
//
//  Created by Dmitry Serebrov on 16.08.2023.
//

import Foundation
struct ViewModel {
	var ping: String
	var upload: String
	var download: String
	var angle: CGFloat
	
	struct PingData {
		var ping: String
	}
	
	struct UploadData {
		var upload: String
		var angle: CGFloat
	}
	
	struct DownloadData {
		var download: String
		var angle: CGFloat
	}
}
