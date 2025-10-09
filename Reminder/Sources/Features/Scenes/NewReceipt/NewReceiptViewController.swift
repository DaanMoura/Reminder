//
//  NewReceipt.swift
//  Reminder
//
//  Created by Daniel Moura on 08/10/25.
//

import Foundation
import UIKit

class NewReceiptViewController: UIViewController {
  private let newReceiptView: NewReceiptView
  private weak var flowDelegate: NewReceiptFlowDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupActions()
  }
  
  private func setupView() {
    view.backgroundColor = Colors.gray800
    view.addSubview(newReceiptView)
    
    setupConstraints()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false
  }

  private func setupConstraints() {
    setupContentViewToBounds(contentView: newReceiptView)
  }
  
  private func setupActions() {
    
  }
  
  init(contentView: NewReceiptView, flowDelegate: NewReceiptFlowDelegate) {
    self.newReceiptView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
