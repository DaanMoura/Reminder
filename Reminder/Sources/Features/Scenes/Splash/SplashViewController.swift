//
//  SplashViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 18/01/25.
//

import Foundation
import UIKit
import LocalAuthentication

class SplashViewController: UIViewController {
  let contentView: SplashView
  public weak var flowDelegate: SplashFlowDelegate?
  
  init(contentView: SplashView,
       flowDelegate: SplashFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Very important lifecycle method:
  // First things that will be executed whe the view is loaded
  override func viewDidLoad() {
    super.viewDidLoad()
    startBreathingAnimation()
    setup()
  }
  
  private func decideNavigationFlow() {
    if let user = UserDefaultsManager.loadUser(), user.isUserSaved {
      user.isFaceIdEnabled ? authenticateWithFaceID() : flowDelegate?.navigateToHome()
    } else {
      showLoginBottomSheet()
    }
  }
  
  private func setup() {
    self.view.addSubview(contentView)
    self.navigationController?.navigationBar.isHidden = true
    self.view.backgroundColor = Colors.primaryRedBase
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    setupContentViewToBounds(contentView: contentView)
  }
  
  private func showLoginBottomSheet() {
    animateLogoUp()
    self.flowDelegate?.openLoginBottomSheet()
  }
}

//MARK: - Animations
extension SplashViewController {
  private func startBreathingAnimation() {
    UIView.animate(withDuration: 1, delay: 0.0, animations: {
      self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }, completion: { _ in
      self.decideNavigationFlow()
    })
  }
  
  private func animateLogoUp() {
    UIView.animate(withDuration: 0.5,
                   delay: 0.0,
                   options: [.curveEaseOut],
                   animations: {
      self.contentView.logoImageView.transform = self.contentView.logoImageView.transform.translatedBy(x: 0, y: -150)
    })
  }
}

//MARK: - Face ID configuration
extension SplashViewController {
  private func authenticateWithFaceID() {
    let context = LAContext()
    var authError: NSError?
    
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
      let reason = "Autentique-se para acessar o app"
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
        DispatchQueue.main.async {
          if success {
            // Autenticação bem sucedida
            self.flowDelegate?.navigateToHome()
          } else {
            // Falhou a autenticação
            self.showLoginBottomSheet()
          }
        }
        
      }
    } else {
      self.showLoginBottomSheet()
    }
    
  }
}

