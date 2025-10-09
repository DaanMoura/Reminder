//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by Daniel Moura on 02/10/25.
//

import Foundation
import UIKit

class ReminderFlowController {
  //MARK: - Properties
  private var navigationController: UINavigationController?
  private var viewControllersFactory: ViewControllersFactoryProtocol
  //MARK: - init
  public init() {
    self.viewControllersFactory = ViewControllersFactory()
  }
    
  //MARK: - startFlow
  func start() -> UINavigationController? {
    let startViewController = viewControllersFactory.makeSplashViewController(flowDelegate: self)
//    let startViewController = viewControllersFactory.makeNewReceiptViewController(flowDelegate: self)
    self.navigationController = UINavigationController(rootViewController: startViewController)
    return navigationController
  }
}

//MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
  func navigateToHome() {
    self.navigationController?.dismiss(animated: true)
    let homeViewController = viewControllersFactory.makeHomeViewController(flowDelegate: self)
    self.navigationController?.pushViewController(homeViewController, animated: true)
  }
}

//MARK: - Splash
extension ReminderFlowController: SplashFlowDelegate {
  func openLoginBottomSheet() {
    let loginBottomSheet = viewControllersFactory.makeLoginBottomSheetViewController(flowDelegate: self)
    loginBottomSheet.modalPresentationStyle = .overCurrentContext
    navigationController?.present(loginBottomSheet, animated: false) {
      loginBottomSheet.animateShow()
    }
  }
}

//MARK: - Home
extension ReminderFlowController: HomeFlowDelegate {
  func navigateToSplashScreen() {
    self.navigationController?.popViewController(animated: true)
    self.openLoginBottomSheet()
  }
  
  func navigateToRecipes() {
    // TODO
  }
  
  func navigateToNewPrescription() {
    let newReceiptViewController = viewControllersFactory.makeNewReceiptViewController(flowDelegate: self)
    self.navigationController?.pushViewController(newReceiptViewController, animated: true)
  }
}

//MARK: - New Receipt
extension ReminderFlowController: NewReceiptFlowDelegate {
  
}

