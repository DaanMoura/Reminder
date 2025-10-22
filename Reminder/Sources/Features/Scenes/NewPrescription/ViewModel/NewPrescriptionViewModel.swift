//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 11/10/25.
//

import Foundation

class NewPrescriptionViewModel {
  func addPrescription(prescription: Prescription) {
    DBHelper.shared.insertPrescription(prescription: prescription)
  }
}
