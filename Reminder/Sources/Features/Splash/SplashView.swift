//
//  SplashView.swift
//  Reminder
//
//  Created by Daniel Moura on 18/01/25.
//

import Foundation
import UIKit

class SplashView: UIView {
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLogoLabel: UILabel = {
        let label = UILabel()
        label.text = "Reminder"
//        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.font = UIFont.boldSystemFont(ofSize: 32)
//        label.textColor = .white
//        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemRed
        self.addSubview(logoImageView)
        self.addSubview(titleLogoLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLogoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 24),
            titleLogoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: titleLogoLabel.leadingAnchor, constant: -8)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
