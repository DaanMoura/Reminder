//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 26/09/25.
//

import Foundation
import UIKit

//MARK: View Controller
class LoginBottomSheetViewController: UIViewController {
  let loginView = LoginBottomSheetView()
  let viewModel = LoginBottomSheetViewModel()
  var handleAreaHeight: CGFloat = 50.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loginView.delegate = self
    setupUI()
    setupGesture()
  }
  
  private func setupUI() {
    self.view.addSubview(loginView)
    loginView.translatesAutoresizingMaskIntoConstraints = false
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
    
//    let heightConstraint: () = loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
      loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
  }
  
  private func setupGesture() {
    // TODO
  }
  
  private func handlePanGesture() {
    // TODO
  }
  
  func animateShow(completion: (() -> Void)? = nil) {
    self.view.layoutIfNeeded()
    loginView.transform = CGAffineTransform(translationX: 0, y: loginView.frame.height)
    UIView.animate(withDuration: 0.3, animations: {
      self.loginView.transform = .identity
      self.view.layoutIfNeeded()
    }) { _ in
      completion?()
    }
  }
}

//MARK: Delegate
extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
  func sendLoginData(user: String, password: String) {
    viewModel.doAuth(usernameLogin: user, password: password)
  }
}
