//
//  NewPrescriptionView.swift
//  Reminder
//
//  Created by Daniel Moura on 09/10/25.
//

import Foundation
import UIKit
import CoreFramework

class NewPrescriptionView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let recurrenceOptions = Recurrence.allCases

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
    return timePicker
  }()
  
  internal let recurrenceInput = Input(
    title: "newPrescription.recurrence.title".localized,
    placeholder: "newPrescription.recurrence.placeholder".localized
  )
  
  private let recurrencePicker: UIPickerView = {
    let picker = UIPickerView()
    return picker
  }()
  

  internal let takeNowCheckbox: Checkbox = {
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
    addSubview(recurrenceInput)
    addSubview(takeNowCheckbox)
    
    addSubview(addButton)
   
    setupTimeInput()
    setupRecurrenceInput()
    setupConstraints()
    setupObservers()
    validateForm()
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
      
      recurrenceInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.larger),
      recurrenceInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      recurrenceInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),

      takeNowCheckbox.topAnchor.constraint(equalTo: recurrenceInput.bottomAnchor, constant: Metrics.medium),
      takeNowCheckbox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
    ])
  }
  
  private func validateForm() {
    let isMedicineFilled = !(medicineInput.textField.text ?? "").isEmpty
    let isTimeFilled = !(timeInput.textField.text ?? "").isEmpty
    let isRecurrenceFilled = !(recurrenceInput.textField.text ?? "").isEmpty
    
    
    let isValid = isMedicineFilled && isTimeFilled && isRecurrenceFilled
    print("validateForm > isValid \(isValid)")
    addButton.isEnabled = isValid
  }
  
  private func setupObservers() {
    medicineInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    timeInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingDidEnd)
    recurrenceInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingDidEnd)
  }
  
  @objc
  private func inputDidChange() {
      validateForm()
  }
  
  private func setupTimeInput() {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectTime))
    toolbar.setItems([flexibleSpace, doneButton], animated: true)
   
    timeInput.textField.inputView = timePicker
    timeInput.textField.inputAccessoryView = toolbar
    
    let assistant = timeInput.textField.inputAssistantItem
    assistant.leadingBarButtonGroups = []
    assistant.trailingBarButtonGroups = []
  }
  
  @objc
  private func didSelectTime() {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    timeInput.textField.text = formatter.string(from: timePicker.date)
    timeInput.textField.resignFirstResponder()
  }
  
  private func setupRecurrenceInput() {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
    
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectRecurrence))
    toolbar.setItems([flexibleSpace, doneButton], animated: true)
    
    recurrenceInput.textField.inputView = recurrencePicker
    recurrenceInput.textField.inputAccessoryView = toolbar
    
    let assistant = recurrenceInput.textField.inputAssistantItem
    assistant.leadingBarButtonGroups = []
    assistant.trailingBarButtonGroups = []
    
    recurrencePicker.delegate = self
    recurrencePicker.dataSource = self
  }
  
  @objc
  private func didSelectRecurrence() {
    let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
    recurrenceInput.textField.text = recurrenceOptions[selectedRow].rawValue
    recurrenceInput.textField.resignFirstResponder()
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
    return recurrenceOptions[row].rawValue
  }
}

