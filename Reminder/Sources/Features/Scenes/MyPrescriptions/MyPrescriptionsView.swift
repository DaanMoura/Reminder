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
  
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "myPrescriptions.title".localized
    label.font = Typography.heading
    label.textColor = Colors.primaryBlueBase
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "myPrescriptions.description.long".localized
    label.numberOfLines = 3
    label.font = Typography.body
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  private func setupUI() {
    self.backgroundColor = Colors.gray600
    
    addSubview(headerBackground)
    
    headerBackground.addSubview(titleLabel)
    headerBackground.addSubview(descriptionLabel)
    
    addSubview(contentBackground)
    
    contentBackground.addSubview(tableView)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    headerBackground.setupDefaultConstraints(to: self, height: 136)
    contentBackground.setupDefaultConstraints(to: self, top: headerBackground)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: headerBackground.topAnchor, constant: Metrics.small),
      titleLabel.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: Metrics.large),
      titleLabel.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -Metrics.large),

      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.little),
      descriptionLabel.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: Metrics.large),
      descriptionLabel.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -Metrics.large),
      
      tableView.topAnchor.constraint(equalTo: contentBackground.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
      tableView.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
      tableView.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor)
    ])
  }
}
