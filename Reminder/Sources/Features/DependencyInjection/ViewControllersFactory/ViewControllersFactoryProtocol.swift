//
//  ViewControllersFactoryProtocol.swift
//  Reminder
//
//  Created by Daniel Moura on 03/10/25.
//

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
  func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
  func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
  func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
}
