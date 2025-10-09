//
//  HomeFlowDelegate.swift
//  Reminder
//
//  Created by Daniel Moura on 04/10/25.
//

import Foundation

public protocol HomeFlowDelegate: AnyObject {
  func navigateToRecipes()
  func navigateToNewPrescription()
  func navigateToSplashScreen()
}
