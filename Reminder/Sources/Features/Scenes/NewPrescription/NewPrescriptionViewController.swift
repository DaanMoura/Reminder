//
//  NewReceipt.swift
//  Reminder
//
//  Created by Daniel Moura on 08/10/25.
//

import Foundation
import UIKit

class NewPrescriptionViewController: UIViewController {
  private let contentView: NewPrescriptionView
  private let viewModel = NewPrescriptionViewModel()
  private weak var flowDelegate: NewPrescriptionFlowDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupActions()
  }
  
  private func setupView() {
    view.backgroundColor = Colors.gray800
    view.addSubview(contentView)
    
    setupConstraints()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false
  }

  private func setupConstraints() {
    setupContentViewToBounds(contentView: contentView)
  }
  
  private func setupActions() {
    contentView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
  }
  
  @objc
  private func addButtonTapped() {
    let medicine = contentView.medicineInput.getText()
    let time = contentView.timeInput.getText()
    let recurrence = contentView.recurrenceInput.getText()
    let takeNow = false // TODO
    
    let prescription = Prescription(id: "",
                                    medicine: medicine,
                                    time: time,
                                    recurrence: recurrence,
                                    takeNow: takeNow)
    
    viewModel.addPrescription(prescription: prescription)
    
    print("receita \(medicine) adicionada")
  }
  
  init(contentView: NewPrescriptionView, flowDelegate: NewPrescriptionFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
