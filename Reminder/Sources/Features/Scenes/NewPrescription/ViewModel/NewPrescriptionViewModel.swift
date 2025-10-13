//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 11/10/25.
//

import Foundation

class NewPrescriptionViewModel {
  func addPrescription(medicine: String, time: String, recurrence: String, takeNow: Bool) {
    DBHelper.shared.insertPrescription(medicine: medicine, time: time, recurrence: recurrence, takeNow: takeNow)
  }
}
