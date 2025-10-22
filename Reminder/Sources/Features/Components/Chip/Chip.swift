//
//  Chip.swift
//  Reminder
//
//  Created by Daniel Moura on 15/10/25.
//

import Foundation
import UIKit

class Chip: UIView {
  let backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = Colors.gray500
    view.layer.cornerRadius = 12
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.tintColor = Colors.gray300
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let chipLabel: UILabel = {
    let label = UILabel()
    label.font = Typography.tag
    label.textColor = Colors.gray100
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  init(text: String, image: UIImage?) {
    super.init(frame: .zero)
    iconImageView.image = image
    chipLabel.text = text
    
    commonInit()
  }
  
  init(image: UIImage?) {
    super.init(frame: .zero)
    iconImageView.image = image
    commonInit()
  }
  
  init() {
    super.init(frame: .zero)
    
    commonInit()
  }
  
  private func commonInit() {
    setupUI()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setText(text: String) {
    chipLabel.text = text
  }
  
  func setImage(image: UIImage?) {
    iconImageView.image = image
  }
  
  private func setupUI() {
    self.addSubview(backgroundView)
    backgroundView.addSubview(iconImageView)
    backgroundView.addSubview(chipLabel)
    
    self.heightAnchor.constraint(equalToConstant: 24).isActive = true
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      
      iconImageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Metrics.tiny),
      iconImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
      iconImageView.widthAnchor.constraint(equalToConstant: Metrics.small),
      iconImageView.heightAnchor.constraint(equalToConstant: Metrics.small),
      
      chipLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Metrics.tiny),
      chipLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -Metrics.small),
      chipLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
    ])
  }
}

