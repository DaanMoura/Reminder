//
//  Checkbox.swift
//  Reminder
//
//  Created by Daniel Moura on 10/10/25.
//

import Foundation
import UIKit
import CoreFramework

public class Checkbox: UIView {
  public let toggleCheckbox:  ToggleCheckbox = {
    let checkbox = ToggleCheckbox()
    checkbox.translatesAutoresizingMaskIntoConstraints = false
    return checkbox
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
    addSubview(toggleCheckbox)
    addSubview(titleLabel)
      
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      toggleCheckbox.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      toggleCheckbox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      toggleCheckbox.widthAnchor.constraint(equalToConstant: Metrics.medium),
      toggleCheckbox.heightAnchor.constraint(equalToConstant: Metrics.medium),
      
      titleLabel.centerYAnchor.constraint(equalTo: toggleCheckbox.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: toggleCheckbox.trailingAnchor, constant: Metrics.small),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}
