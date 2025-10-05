//
//  SplashFlowDelegate.swift
//  Reminder
//
//  Created by Daniel Moura on 02/10/25.
//

import Foundation

public protocol SplashFlowDelegate: AnyObject {
  func openLoginBottomSheet()
  func navigateToHome()
}
