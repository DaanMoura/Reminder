//
//  SplashView.swift
//  Reminder
//
//  Created by Daniel Moura on 18/01/25.
//

import Foundation
import UIKit

class SplashView: UIView {
  internal let logoImageView: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "Logo")
    image.contentMode = .scaleAspectFit
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    self.backgroundColor = Colors.primaryRedBase
    self.addSubview(logoImageView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
    
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
