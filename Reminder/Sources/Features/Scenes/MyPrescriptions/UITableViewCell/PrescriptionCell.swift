//
//  PrescriptionCell.swift
//  Reminder
//
//  Created by Daniel Moura on 15/10/25.
//

import Foundation
import UIKit

class PrescriptionCell: UITableViewCell {
  static let identifier = "PrescriptionCell"
  
  var onDelete: (() -> Void)?
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = Typography.subheading
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let timeChip = Chip(image: UIImage(systemName: "clock"))
  
  private let recurrenceChip = Chip(image: UIImage(systemName: "repeat"))
  
  private let trashButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(systemName: "trash")
    button.setImage(image, for: .normal)
//    button.configuration = .glass()
    button.tintColor = Colors.primaryRedBase
    button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 12, weight: .heavy)
    
    button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    contentView.backgroundColor = Colors.gray700
    contentView.layer.masksToBounds = true
    contentView.layer.cornerRadius = 12
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(timeChip)
    contentView.addSubview(recurrenceChip)
    contentView.addSubview(trashButton)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.small),
      
      timeChip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
      timeChip.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
      timeChip.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.small),
      
      recurrenceChip.leadingAnchor.constraint(equalTo: timeChip.trailingAnchor, constant: Metrics.little),
      recurrenceChip.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
      recurrenceChip.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.small),
      
      trashButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.small),
      trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.small),
      trashButton.widthAnchor.constraint(equalToConstant: 16),
      trashButton.heightAnchor.constraint(equalToConstant: 16)
    ])
  }
  
  func configure(prescription: Prescription) {
    titleLabel.text = prescription.medicine
    timeChip.setText(text: prescription.time)
    recurrenceChip.setText(text: prescription.recurrence)
  }
  
  @objc
  private func trashButtonTapped() {
    onDelete?()
  }

}
