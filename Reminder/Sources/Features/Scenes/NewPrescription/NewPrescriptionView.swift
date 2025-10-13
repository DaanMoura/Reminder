//
//  NewPrescriptionView.swift
//  Reminder
//
//  Created by Daniel Moura on 09/10/25.
//

import Foundation
import UIKit

class NewPrescriptionView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescription.title".localized
    label.font = Typography.heading
    label.textColor = Colors.primaryRedBase
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescription.description.long".localized
    label.numberOfLines = 3
    label.font = Typography.body
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  internal let medicineInput = Input(
    title: "newPrescription.medicine.title".localized,
    placeholder: "newPrescription.medicine.placeholder".localized
  )
  
  internal let timeInput = Input(
    title: "newPrescription.time.title".localized,
    placeholder: "newPrescription.time.placeholder".localized
  )
  
  private let timePicker: UIDatePicker = {
    let timePicker = UIDatePicker()
    timePicker.datePickerMode = .dateAndTime
    timePicker.preferredDatePickerStyle = .wheels
    timePicker.translatesAutoresizingMaskIntoConstraints = false
    return timePicker
  }()
  
  internal let recurrenceInput = Input(
    title: "newPrescription.recurrence.title".localized,
    placeholder: "newPrescription.recurrence.placeholder".localized
  )
  
  private let recurrencePicker: UIPickerView = {
    let picker = UIPickerView()
    picker.translatesAutoresizingMaskIntoConstraints = false
    return picker
  }()
  
  let recurrenceOptions = [
    "De hora em hora",
    "2 em 2 horas",
    "4 em 4 horas",
    "6 em 6 horas",
    "8 em 8 horas",
    "12 em 12 horas",
    "1 por dia"
  ]
  
  private let takeNowCheckbox: Checkbox = {
    let checkbox = Checkbox(title: "newPrescription.takeNow.title".localized)
    return checkbox
  }()
  
  internal let addButton: Button = {
    let button = Button()
    let buttonImage = UIImage(systemName: "plus")
    button.setImage(buttonImage, for: .normal)
    button.setTitle("newPrescription.add.button.title".localized, for: .normal)
    button.tintColor = Colors.primaryRedBase
    //    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    return button
  }()

  private func setupUI() {
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    
    addSubview(medicineInput)
    addSubview(timeInput)
//    addSubview(hourLabel)
//    addSubview(hourTimePicker)
//    addSubview(recurrenceLabel)
    addSubview(takeNowCheckbox)
    
    addSubview(addButton)
   
    setupTimeInput()
    setupRecurrenceInput()
    setupConstraints()
  }
  
  private func setupConstraints() {
    addButton.setupDefaultConstraints(to: self)
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
      
      timeInput.topAnchor.constraint(equalTo: medicineInput.bottomAnchor, constant: Metrics.larger),
      timeInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      timeInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),

//      TODO: add recorrency constraints
      
      takeNowCheckbox.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.medium),
      takeNowCheckbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
    ])
  }
  
  private func setupTimeInput() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectTime))
    toolbar.setItems([doneButton], animated: true)
   
    timeInput.textField.inputView = timePicker
    timeInput.textField.inputAccessoryView = toolbar
  }
  
  @objc
  private func didSelectTime() {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    timeInput.textField.text = formatter.string(from: timePicker.date)
    timeInput.textField.resignFirstResponder()
  }
  
  private func setupRecurrenceInput() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectRecurrence))
    toolbar.setItems([doneButton], animated: true)
    
    recurrenceInput.textField.inputView = recurrencePicker
    recurrenceInput.textField.inputAccessoryView = toolbar
    
    recurrencePicker.delegate = self
    recurrencePicker.dataSource = self
  }
  
  @objc
  private func didSelectRecurrence() {
    let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
    recurrenceInput.textField.text = recurrenceOptions[selectedRow]
    recurrenceInput.resignFirstResponder()
  }
}

extension NewPrescriptionView: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return recurrenceOptions.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return recurrenceOptions[row]
  }
}

