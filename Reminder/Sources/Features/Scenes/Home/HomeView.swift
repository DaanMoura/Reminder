//
//  HomeView.swift
//  Reminder
//
//  Created by Daniel Moura on 04/10/25.
//

import Foundation
import UIKit
import CoreFramework

class HomeView: UIView {
  public weak var delegate: HomeViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupTextField()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let profileBackground = HeaderBackground()
  
  private let contentBackground = ContentBackground()
  
  internal let profileImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "person.fill")
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.isUserInteractionEnabled = true
    imageView.layer.cornerRadius = Metrics.profileImageSize / 2
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = Colors.primaryBlueBase.cgColor
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let logoutIconButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = Colors.primaryRedBase
    button.configuration = .clearGlass()
    button.configuration?.baseForegroundColor = Colors.primaryRedBase
    button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: Metrics.small, leading: 28, bottom: Metrics.small, trailing: Metrics.medium)
    button.configuration?.buttonSize = .large
    button.configuration?.imagePadding = Metrics.iconButtonPadding
    button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                    for: .normal)
    button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: Metrics.buttonIconSize, weight: .heavy)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(onLogoutButtonTap), for: .touchUpInside)
    return button
    
  }()
  
  private let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "home.welcome.label".localized
    label.font = Typography.input
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  internal let nameTextField: UITextField = {
    let textField = UITextField()
    textField.textColor = Colors.gray100
    textField.font = Typography.heading
    textField.returnKeyType = .done
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private let myPrescriptionsButton: ButtonHomeView = {
    let buttonHomeView = ButtonHomeView(
      icon: UIImage(named: "paper-icon"),
      title: "myPrescriptions.title".localized,
      description: "myPrescriptions.description.short".localized,
    )
    return buttonHomeView
  }()
  
  private let newPrescriptionButton: ButtonHomeView = {
    let buttonHomeView = ButtonHomeView(
      icon: UIImage(named: "pills-icon"),
      title: "newPrescription.title".localized,
      description: "newPrescription.description.short".localized,
    )
    return buttonHomeView
  }()

  private let feedbackButton: Button = {
    let button = Button()
    let buttonImage = UIImage(systemName: "star")
    button.setImage(buttonImage, for: .normal)
    button.setTitle("home.feedback.button.title".localized, for: .normal)
    button.tintColor = Colors.gray100
    button.addTarget(self, action: #selector(onFeedbackButtonTap), for: .touchUpInside)
    return button
  }()
  
  private func setupUI() {
    self.backgroundColor = Colors.gray600
    
    addSubview(profileBackground)
    
    profileBackground.addSubview(profileImage)
    profileBackground.addSubview(logoutIconButton)
    profileBackground.addSubview(welcomeLabel)
    profileBackground.addSubview(nameTextField)
    
    addSubview(contentBackground)
    
    contentBackground.addSubview(myPrescriptionsButton)
    contentBackground.addSubview(newPrescriptionButton)
    contentBackground.addSubview(feedbackButton)
    
    setupConstraints()
    setupImageGesture()
    setupActions()
  }
  
  private func setupConstraints() {
    feedbackButton.setupDefaultConstraints(to: self)
    profileBackground.setupDefaultConstraints(to: self)
    contentBackground.setupDefaultConstraints(to: self, top: profileBackground)
    
    NSLayoutConstraint.activate([
      //MARK: - Profile background constrainsts
      
      profileImage.topAnchor.constraint(equalTo: profileBackground.topAnchor),
      profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.large),
      profileImage.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize),
      profileImage.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize),
      
      logoutIconButton.topAnchor.constraint(equalTo: profileBackground.topAnchor),
      logoutIconButton.trailingAnchor.constraint(equalTo: profileBackground.trailingAnchor, constant: -Metrics.large),
      
      welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.medium),
      welcomeLabel.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.large),
      
      nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.small),
      nameTextField.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.large),
      
      //MARK: - Content background constraints
      
      myPrescriptionsButton.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.large),
      myPrescriptionsButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
      myPrescriptionsButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
      
      newPrescriptionButton.topAnchor.constraint(equalTo: myPrescriptionsButton.bottomAnchor, constant: Metrics.medier),
      newPrescriptionButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
      newPrescriptionButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
    ])
  }
  
  private func setupTextField() {
    nameTextField.delegate = self
  }
  
  private func setupImageGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: #selector(onProfileImageTap))
    profileImage.addGestureRecognizer(tapGestureRecognizer)
  }
  
  private func setupActions() {
    newPrescriptionButton.tapAction = { [weak self] in
      self?.delegate?.didTapNewPrescriptionButton()
    }
    
    myPrescriptionsButton.tapAction = { [weak self] in
      self?.delegate?.didTapMyPrescriptionsButton()
    }
  }
  
  
  @objc
  private func onLogoutButtonTap() {
    delegate?.didTapLogoutButton()
  }
  
  @objc
  private func onProfileImageTap() {
    delegate?.didTapProfileImage()
  }
  
  @objc
  private func onFeedbackButtonTap() {
    delegate?.didTapFeedbackButton()
  }
}

extension HomeView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    let userName = nameTextField.text ?? ""
    UserDefaultsManager.saveUserName(name: userName)
    return true
  }
}

