//
//  MyPrescriptionsView.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation
import UIKit

class MyPrescriptionsView: UIView {
  weak public var delegate: MyPrescriptionsViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let headerBackground = HeaderBackground()
  
  private let contentBackground = ContentBackground()
  
  private func setupUI() {
    self.backgroundColor = Colors.gray600
    
    addSubview(headerBackground)
    addSubview(contentBackground)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerBackground.setupDefaultConstraints(to: self, height: 200)
    contentBackground.setupDefaultConstraints(to: self, top: headerBackground)
    
    NSLayoutConstraint.activate([
    ])
  }
}
