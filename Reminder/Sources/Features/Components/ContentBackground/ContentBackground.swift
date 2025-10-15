//
//  ContentBackground.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation
import UIKit

public final class ContentBackground: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.cornerRadius = Metrics.medium
    self.layer.masksToBounds = false
    self.backgroundColor = Colors.gray800
    self.layer.shadowColor = Colors.gray200.cgColor
    self.layer.shadowRadius = 24
    self.layer.shadowOpacity = 0.25
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func setupDefaultConstraints(to: UIView, top: UIView) {
    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: top.bottomAnchor),
      self.leadingAnchor.constraint(equalTo: to.leadingAnchor),
      self.trailingAnchor.constraint(equalTo: to.trailingAnchor),
      self.bottomAnchor.constraint(equalTo: to.bottomAnchor),
    ])
  }
}
