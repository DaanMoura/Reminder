//
//  MyPrescriptionsViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation
import UIKit

class MyPrescriptionsViewController: UIViewController {
  private let contentView: MyPrescriptionsView
  private let viewModel = MyPrescriptionsViewModel()
  private weak var flowDelegate: MyPrescriptionsFlowDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentView.delegate = self
    setupView()
  }
  
  private func setupView() {
    view.backgroundColor = Colors.gray600
    view.addSubview(contentView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    guard self.view !== contentView else { return }
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  init(contentView: MyPrescriptionsView, flowDelegate: MyPrescriptionsFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MyPrescriptionsViewController: MyPrescriptionsViewDelegate {
  
  
}
