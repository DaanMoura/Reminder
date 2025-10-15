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
  
  func makeNewPrescriptionViewController(flowDelegate: NewPrescriptionFlowDelegate) -> NewPrescriptionViewController {
    let contentView = NewPrescriptionView()
    let viewController = NewPrescriptionViewController(contentView: contentView,
                                                  flowDelegate: flowDelegate)
    return viewController
  }
  
  func makeMyPrescriptionsViewController(flowDelegate: MyPrescriptionsFlowDelegate) -> MyPrescriptionsViewController {
    let contentView = MyPrescriptionsView()
    let viewController = MyPrescriptionsViewController(contentView: contentView,
                                                       flowDelegate: flowDelegate)
    return viewController
  }
}
