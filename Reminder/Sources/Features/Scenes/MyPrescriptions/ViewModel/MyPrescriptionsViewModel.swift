//
//  MyPrescriptionsViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation

class MyPrescriptionsViewModel {
  func fetchData() -> [Prescription] {
    return DBHelper.shared.fetchPrescriptions()
  }
}
