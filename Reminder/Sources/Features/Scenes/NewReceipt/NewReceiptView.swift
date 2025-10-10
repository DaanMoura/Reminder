//
//  NewReceiptView.swift
//  Reminder
//
//  Created by Daniel Moura on 09/10/25.
//

import Foundation
import UIKit

class NewReceiptView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.title".localized
    label.font = Typography.heading
    label.textColor = Colors.primaryRedBase
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.description.long".localized
    label.numberOfLines = 3
    label.font = Typography.body
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let medicineInput = Input(
    title: "newPrescriptions.medicine.title".localized,
    placeholder: "newPrescriptions.medicine.placeholder".localized
  )
  
  private let hourLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.hour.title".localized
    label.font = Typography.label
    label.textColor = Colors.gray100
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let hourTimePicker: UIDatePicker = {
    let timePicker = UIDatePicker()
    timePicker.datePickerMode = .time
    timePicker.translatesAutoresizingMaskIntoConstraints = false
    return timePicker
  }()
  
  private let recorrencyLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.recorrency.title".localized
    label.font = Typography.label
    label.textColor = Colors.gray100
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // TODO: Recorrency select
  
  private let useNowCheckbox: UIButton = {
    let button = UIButton(type: .system)
    let checkImage = UIImage(systemName: "checkmark")
    button.setImage(checkImage, for: .selected)
    button.layer.cornerRadius = Metrics.tiny
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let useNowLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.useNow.title".localized
    label.font = Typography.input
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let addButton: UIButton = {
    let button = UIButton(type: .system)
    let buttonImage = UIImage(systemName: "plus")
    button.setImage(buttonImage, for: .normal)
    button.setTitle("newPrescriptions.add.button.title".localized, for: .normal)
    button.layer.cornerRadius = Metrics.medium
    button.tintColor = Colors.primaryRedBase
    
    button.configuration = .prominentGlass()
    button.configuration?.imagePadding = Metrics.little
    button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
        var outgoing = incoming
        outgoing.font = Typography.subheading
        return outgoing
    }
    button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: Metrics.buttonIconSize, weight: .heavy)

//    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private func setupUI() {
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    
    addSubview(medicineInput)
    addSubview(hourLabel)
    addSubview(hourTimePicker)
    addSubview(recorrencyLabel)
    addSubview(useNowCheckbox)
    addSubview(useNowLabel)
    
    addSubview(addButton)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),

      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.little),
      descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      
      medicineInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.larger),
      medicineInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      medicineInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),

      hourLabel.topAnchor.constraint(equalTo: medicineInput.bottomAnchor, constant: Metrics.medium),
      hourLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      hourLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      
      hourTimePicker.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: Metrics.small),
      hourTimePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      hourTimePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      hourTimePicker.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -Metrics.large * 2),
      hourTimePicker.heightAnchor.constraint(equalToConstant: Metrics.inputHeight),
      
//      TODO: add recorrency constraints
      
      useNowCheckbox.topAnchor.constraint(equalTo: hourTimePicker.bottomAnchor, constant: Metrics.small),
//      useNowCheckbox.topAnchor.constraint(equalTo: medicineTextField.bottomAnchor, constant: Metrics.small),
      useNowCheckbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      useNowCheckbox.widthAnchor.constraint(equalToConstant: Metrics.medium),
      useNowCheckbox.heightAnchor.constraint(equalToConstant: Metrics.medium),
      
      useNowLabel.centerYAnchor.constraint(equalTo: useNowCheckbox.centerYAnchor),
      useNowLabel.leadingAnchor.constraint(equalTo: useNowCheckbox.trailingAnchor, constant: Metrics.small),

      addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.tiny),
      addButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)
    ])
  }
}

