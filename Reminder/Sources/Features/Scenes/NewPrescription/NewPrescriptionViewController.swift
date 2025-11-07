//
//  NewReceipt.swift
//  Reminder
//
//  Created by Daniel Moura on 08/10/25.
//

import Foundation
import UIKit
import Lottie
import CoreFramework

class NewPrescriptionViewController: UIViewController {
  private let contentView: NewPrescriptionView
  private let viewModel = NewPrescriptionViewModel()
  private weak var flowDelegate: NewPrescriptionFlowDelegate?
  
  private let successAnimationView: LottieAnimationView = {
    let animationView = LottieAnimationView(name: "success")
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .playOnce
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.isHidden = true
    return animationView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupActions()
    let onboarding = OnboardingView()
    onboarding.presentOnboarding(on: view, with: ["instrução 1", "instrução 2", "instrução 3"])
  }
  
  private func setupView() {
    view.backgroundColor = Colors.gray800
    view.addSubview(contentView)
    view.addSubview(successAnimationView)
    
    setupConstraints()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.isHidden = false
  }

  private func setupConstraints() {
    setupContentViewToBounds(contentView: contentView)
    NSLayoutConstraint.activate([
      successAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      successAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
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
    
    let prescription = Prescription(id: 0,
                                    medicine: medicine,
                                    time: time,
                                    recurrence: Recurrence(rawValue: recurrence) ?? Recurrence.daily,
                                    takeNow: takeNow)
    
    viewModel.addPrescription(prescription: prescription)
    playSuccessAnimation()
    clearFields()
    contentView.addButton.isEnabled = false
    
    print("receita \(medicine) adicionada")
  }
  
  private func clearFields() {
    contentView.medicineInput.textField.text = ""
    contentView.timeInput.textField.text = ""
    contentView.recurrenceInput.textField.text = ""
  }
  
  private func playSuccessAnimation() {
    successAnimationView.isHidden = false
    successAnimationView.play { [weak self] finished in
      if finished {
        self?.successAnimationView.isHidden = true
      }
    }
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
