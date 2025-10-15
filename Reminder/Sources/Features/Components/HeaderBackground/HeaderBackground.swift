//
//  HeaderBackground.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation
import UIKit

public final class HeaderBackground: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = Colors.gray600
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func setupDefaultConstraints(to: UIView) {
    setupDefaultConstraintsCommom(to: to, height: Metrics.headerBackgroundSize)
  }
  
  public func setupDefaultConstraints(to: UIView, height: CGFloat) {
    setupDefaultConstraintsCommom(to: to, height: height)
  }
  
  private func setupDefaultConstraintsCommom(to: UIView, height: CGFloat) {
    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: to.safeAreaLayoutGuide.topAnchor),
      self.leadingAnchor.constraint(equalTo: to.leadingAnchor),
      self.trailingAnchor.constraint(equalTo: to.trailingAnchor),
      self.heightAnchor.constraint(equalToConstant: height),
    ])
  }

}
