//
//  SplashViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 18/01/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    // TODO: add it by dependency injection
    let contentView = SplashView()

    // Very important lifecycle method:
    // First things that will be executed whe the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
       
        // Always set this to false on UIKit
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}

