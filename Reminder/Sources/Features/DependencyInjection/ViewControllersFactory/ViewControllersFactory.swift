//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Daniel Moura on 03/10/25.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
  func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
    let contentView = SplashView()
    let viewController = SplashViewController(contentView: contentView,
                                              flowDelegate: flowDelegate)
    return viewController
  }
  
  func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
    let contentView = LoginBottomSheetView()
    let viewController = LoginBottomSheetViewController(contentView: contentView,
                                                        flowDelegate: flowDelegate)
    return viewController
  }
  
  func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
    let contentView = HomeView()
    let viewController = HomeViewController(contentView: contentView,
                                            flowDelegate: flowDelegate)
    return viewController
  }
  
  func makeNewReceiptViewController(flowDelegate: NewReceiptFlowDelegate) -> NewReceiptViewController {
    let contentView = NewReceiptView()
    let viewController = NewReceiptViewController(contentView: contentView,
                                                  flowDelegate: flowDelegate)
    return viewController
  }
}
