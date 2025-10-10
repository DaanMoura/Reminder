//
//  ButtonHomeView.swift
//  Reminder
//
//  Created by Daniel Moura on 07/10/25.
//

import Foundation
import UIKit

class ButtonHomeView: UIView {
  var tapAction: (() -> Void)?
  
  private let backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = Colors.gray700
    view.layer.cornerRadius = 12
    view.layer.borderWidth = 1
    view.layer.borderColor = Colors.gray600.cgColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let iconView: UIView = {
    let view = UIView()
    view.backgroundColor = Colors.gray600
    view.layer.cornerRadius = 8
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = Typography.subheading
    label.textColor = Colors.gray100
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = Typography.body
    label.textColor = Colors.gray200
    label.numberOfLines = 3
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let chevronImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    imageView.tintColor = Colors.gray400
    imageView.preferredSymbolConfiguration = .init(pointSize: Metrics.chevronSize, weight: .semibold)
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private func setupUI() {
    self.addSubview(backgroundView)
    backgroundView.addSubview(iconView)
    iconView.addSubview(iconImageView)
    backgroundView.addSubview(titleLabel)
    backgroundView.addSubview(descriptionLabel)
    backgroundView.addSubview(chevronImageView)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
//      backgroundView.heightAnchor.constraint(equalToConstant: Metrics.buttonHomeHeight),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
      iconView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Metrics.small),
      iconView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Metrics.small),
      iconView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -Metrics.small),
      iconView.widthAnchor.constraint(equalToConstant: 80),
      iconView.heightAnchor.constraint(equalToConstant: 80),
      
      iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
      iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
      iconImageView.widthAnchor.constraint(equalToConstant: Metrics.iconImageHeight),
      iconImageView.heightAnchor.constraint(equalToConstant: Metrics.iconImageHeight),
     
      titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Metrics.small),
      titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Metrics.medium),
      titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Metrics.medier),
      
      descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Metrics.small),
      descriptionLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Metrics.medium),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.little),
      
      chevronImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Metrics.medier),
      chevronImageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Metrics.medier)
    ])
  }
  
  init(icon: UIImage?, title: String, description: String) {
    super.init(frame: .zero)
    iconImageView.image = icon
    titleLabel.text = title
    descriptionLabel.text = description
    
    setupUI()
    setupConstraints()
    setupGesture()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(onTapGesture)
    )
    self.addGestureRecognizer(tapGestureRecognizer)
    self.isUserInteractionEnabled = true
  }
  
  @objc
  private func onTapGesture() {
    tapAction?()
  }

}
