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
  private var bottomPaddingConstraint: NSLayoutConstraint?
  
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
    button.layer.cornerRadius = Metrics.medium
    button.titleLabel?.font = Typography.subheading
    button.tintColor = Colors.primaryRedBase
    button.configuration = .prominentGlass()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    registerForKeyboardNotifications()
    setupTapToDismissKeyboard()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  private func setupTapToDismissKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismiss))
    tap.cancelsTouchesInView = false // allow buttons/controls to still receive touches
    addGestureRecognizer(tap)
  }
  
  private func setupUI() {
    self.backgroundColor = .white
    self.layer.cornerRadius = Metrics.small
    self.layer.cornerCurve = .continuous
    self.layer.shadowColor = Colors.gray200.cgColor
    self.layer.shadowRadius = 24
    self.layer.shadowOpacity = 0.25
    self.layer.masksToBounds = false

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
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.medium),
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
    ])

    bottomPaddingConstraint = loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.large)
    bottomPaddingConstraint?.isActive = true

    NSLayoutConstraint.activate([
      loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)
    ])
  }

  private func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  @objc
  private func keyboardWillChangeFrame(_ notification: Notification) {
    guard
      let userInfo = notification.userInfo,
      let endFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
      let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
      let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    else { return }

    // Work in window coordinates to avoid intermediate conversion issues
    guard let window = self.window else { return }
    let keyboardEndFrameInWindow = endFrameValue.cgRectValue
    let sheetFrameInWindow = self.convert(self.bounds, to: window)

    // Overlap is how much the keyboard intrudes into the sheet's bottom in window space
    let overlap = max(0, sheetFrameInWindow.maxY - keyboardEndFrameInWindow.minY)
    let extraPadding: CGFloat = 12
    let translationY = -(overlap + extraPadding)

    let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      // Animate to the latest target; if overlap becomes 0 during the same animation tick, identity wins
      self.transform = overlap > 0 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
      // If you’re also animating the presenting controller’s layout, call layoutIfNeeded there instead.
    })
  }


  @objc
  private func keyboardWillHide(_ notification: Notification) {
    guard
      let userInfo = notification.userInfo,
      let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
      let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    else { return }

    let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      self.transform = .identity
    })
  }
 
  @objc
  private func handleTapToDismiss() {
    endEditing(true)
  }

  @objc
  private func loginButtonDidTap() {
    let user = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    delegate?.sendLoginData(user: user, password: password)
  }
}

