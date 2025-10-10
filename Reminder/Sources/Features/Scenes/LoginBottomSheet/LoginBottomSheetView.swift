//
//  LoginBottomSheetView.swift
//  Reminder
//
//  Created by Daniel Moura on 26/09/25.
//

import Foundation
import UIKit

class LoginBottomSheetView: UIView {
  public weak var delegate: LoginBottomSheetViewDelegate?
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "login.welcome.title".localized
    label.font = Typography.heading
    label.isUserInteractionEnabled = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let emailInput = Input(
    title: "login.email.label".localized,
    placeholder: "login.email.placeholder".localized
  )
  
  private let passwordInput: Input = {
    let input = Input(
      title: "login.password.label".localized,
      placeholder: "login.password.placeholder".localized
    )
    input.enableSecureText()
    return input
  }()
  
  private let loginButton: Button = {
//    let button = UIButton(type: .system)
    let button = Button()
    button.setTitle("login.button.title".localized, for: .normal)
    button.tintColor = Colors.primaryRedBase
    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.backgroundColor = .white
    self.layer.cornerRadius = Metrics.small
    self.layer.cornerCurve = .continuous
    self.layer.masksToBounds = true

    addSubview(titleLabel)
//    addSubview(emailFieldLabel)
//    addSubview(emailTextField)
//    addSubview(passwordFieldLabel)
//    addSubview(passwordTextField)
    addSubview(emailInput)
    addSubview(passwordInput)
    addSubview(loginButton)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    loginButton.setupDefaultConstraints(to: self)
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.medium),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      
      emailInput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.larger),
      emailInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      emailInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      
      passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: Metrics.larger),
      passwordInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      passwordInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),

//      loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
//      loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
//      loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.large),
//      loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)
    ])
  }
 
  @objc
  private func loginButtonDidTap() {
    let user = emailInput.getText()
    let password = passwordInput.getText()
    delegate?.sendLoginData(user: user, password: password)
  }
}

