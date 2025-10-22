//
//  Prescription.swift
//  Reminder
//
//  Created by Daniel Moura on 20/10/25.
//

import Foundation

struct Prescription: Codable {
  let id: String
  let medicine: String
  let time: String
  let recurrence: String
  let takeNow: Bool
}

