//
//  MyPrescriptionsViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation
import UserNotifications

class MyPrescriptionsViewModel {
  func fetchData() -> [Prescription] {
    return DBHelper.shared.fetchPrescriptions()
  }
  
  func deletePrescription(byId id: Int) {
    DBHelper.shared.deletePrescription(byId: id)
    removeNotifications(for: id)
  }
  
  private func removeNotifications(for prescriptionId: Int) {
    let center = UNUserNotificationCenter.current()
    let identifiers = (0..<24).map { "\(prescriptionId)_\($0)"}
    print("Notificações para \(identifiers) removidas")
  }
}
