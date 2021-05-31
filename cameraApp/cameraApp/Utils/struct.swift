//
//  SessionResult.swift
//  cameraApp
//
//  Created by Pasonatech on 2021/05/28.
//

import Foundation

enum SessionSetupResult {
    case success
    case notAuthorized
    case configurationFailed
}

enum toView: String {
    case text = "showText"
    case camera = "showCamera"
}

enum PortraitEffectsMatteDeliveryMode {
    case on
    case off
}
