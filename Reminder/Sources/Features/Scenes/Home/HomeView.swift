//
//  HomeView.swift
//  Reminder
//
//  Created by Daniel Moura on 04/10/25.
//

import Foundation
import UIKit

class HomeView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  private let profileBackground: UIView = {
//    let view = UIView()
//    view.b
//  }()
  
  private let profileImage: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(systemName: "person.fill")
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  private let logoutIconButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = Colors.primaryRedBase
    button.configuration = .prominentClearGlass()
    button.configuration?.baseForegroundColor = Colors.primaryRedBase
    button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: Metrics.small, leading: Metrics.medium, bottom: Metrics.small, trailing: Metrics.medium)
    button.configuration?.buttonSize = .medium
    button.configuration?.imagePadding = 24.0
    button.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                    for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "Boas vindas"
    label.font = Typography.label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Daniel Moura"
    label.font = Typography.heading
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let rateButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "star.fill"), for: .normal)
    button.setTitle("Avaliar", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    button.layer.cornerRadius = Metrics.medium
    button.titleLabel?.font = Typography.subheading
    button.tintColor = .black
    button.configuration = .prominentGlass()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private func setupUI() {
    self.backgroundColor = Colors.background
    
    addSubview(profileImage)
    addSubview(logoutIconButton)
    addSubview(welcomeLabel)
    addSubview(nameLabel)
    addSubview(rateButton)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
      profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      profileImage.widthAnchor.constraint(equalToConstant: 64),
      profileImage.heightAnchor.constraint(equalToConstant: 64),
      
      logoutIconButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
      logoutIconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      
      welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.medium),
      welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      
      nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.small),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      
      rateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      rateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      rateButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.tiny),
      rateButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)

    ])
  }
}

