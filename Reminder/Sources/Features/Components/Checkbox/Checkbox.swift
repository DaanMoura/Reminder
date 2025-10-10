//
//  Checkbox.swift
//  Reminder
//
//  Created by Daniel Moura on 10/10/25.
//

import Foundation
import UIKit

public class Checkbox: UIView {
  private let checkboxButton: UIButton = {
    let button = UIButton(type: .system)
    
    let squareImage = UIImage(systemName: "square")
    button.setImage(squareImage, for: .normal)
    
    let checkImage = UIImage(systemName: "checkmark.square")
    button.setImage(checkImage, for: .selected)
    
    button.tintColor = Colors.gray400
    button.layer.cornerRadius = Metrics.tiny
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = Typography.label
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  init(title: String) {
    super.init(frame: .zero)
    
    translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(checkboxButton)
    addSubview(titleLabel)
      
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      checkboxButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      checkboxButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      checkboxButton.widthAnchor.constraint(equalToConstant: Metrics.medium),
      checkboxButton.heightAnchor.constraint(equalToConstant: Metrics.medium),
      
      titleLabel.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: Metrics.small),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
  
  public func toggle() {
    checkboxButton.isSelected.toggle()
  }
}
