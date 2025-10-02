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
  
  private let handleArea: UIView = {
    let view = UIView()
    view.backgroundColor = .lightGray
    view.layer.cornerRadius = Metrics.tiny
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "login.welcome.title".localized
    label.font = Typography.heading
    label.isUserInteractionEnabled = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let emailFieldLabel: UILabel = {
    let label = UILabel()
    label.text = "login.email.label".localized
    label.font = Typography.label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let emailTextField: UITextField = {
    let text = UITextField()
    text.placeholder = "login.email.placeholder".localized
    text.borderStyle = .roundedRect
    text.font = Typography.input
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
  }()
  
  private let passwordFieldLabel: UILabel = {
    let label = UILabel()
    label.text = "login.password.label".localized
    label.font = Typography.label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let passwordTextField: UITextField = {
    let text = UITextField()
    text.placeholder = "login.password.placeholder".localized
    text.borderStyle = .roundedRect
    text.font = Typography.input
    text.isSecureTextEntry = true
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
  }()
  
  private let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("login.button.title".localized, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    button.backgroundColor = Colors.primaryRedBase
    button.layer.cornerRadius = Metrics.medium
    button.titleLabel?.font = Typography.subheading
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
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
   
    addSubview(handleArea)
    addSubview(titleLabel)
    addSubview(emailFieldLabel)
    addSubview(emailTextField)
    addSubview(passwordFieldLabel)
    addSubview(passwordTextField)
    addSubview(loginButton)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      handleArea.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),
      handleArea.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      handleArea.widthAnchor.constraint(equalToConstant: 40),
      handleArea.heightAnchor.constraint(equalToConstant: 6),
      
      titleLabel.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: Metrics.medium),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      
      emailFieldLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
      emailFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
     
      emailTextField.topAnchor.constraint(equalTo: emailFieldLabel.bottomAnchor, constant: Metrics.small),
      emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Metrics.large * 2),
      emailTextField.heightAnchor.constraint(equalToConstant: Metrics.inputHeight),
      
      passwordFieldLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
      passwordFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      
      passwordTextField.topAnchor.constraint(equalTo: passwordFieldLabel.bottomAnchor, constant: Metrics.small),
      passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Metrics.large * 2),
      passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.inputHeight),

      loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.large),
      loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)
    ])
  }
 
  @objc
  private func loginButtonDidTap() {
    let user = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    delegate?.sendLoginData(user: user, password: password)
  }
}
