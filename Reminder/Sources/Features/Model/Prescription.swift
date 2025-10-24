//
//  Prescription.swift
//  Reminder
//
//  Created by Daniel Moura on 20/10/25.
//

import Foundation

struct Prescription: Decodable {
  let id: Int
  let medicine: String
  let time: String
  let recurrence: Recurrence
  let takeNow: Bool
}

