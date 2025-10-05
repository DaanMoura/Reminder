//
//  HomeViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 04/10/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
  let contentView: HomeView
  public weak var flowDelegate: HomeFlowDelegate?
  
  init(contentView: HomeView,
       flowDelegate: HomeFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
     
    setupBindView()
    setup()
  }
  
  private func setupBindView() {
    self.view = contentView
  }
  
  private func setup() {
    buildHierarchy()
  }
  
  private func buildHierarchy() {
    // If the contentView is already the controller's root view, don't add constraints to it again.
    guard self.view !== contentView else { return }
    setupContentViewToBounds(contentView: contentView)
  }
  
}
