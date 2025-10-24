//
//  Recurrence.swift
//  Reminder
//
//  Created by Daniel Moura on 23/10/25.
//

import Foundation

/// Represents the recurrence schedule for a prescription.
/// Uses Portuguese display strings as raw values for direct UI usage.
public enum Recurrence: String, CaseIterable, Equatable, Decodable {
  case hourly = "De hora em hora"
  case every2Hours = "2 em 2 horas"
  case every4Hours = "4 em 4 horas"
  case every6Hours = "6 em 6 horas"
  case every8Hours = "8 em 8 horas"
  case every12Hours = "12 em 12 horas"
  case daily = "1 por dia"
}

extension Recurrence {
  /// The recurrence interval expressed in whole hours.
  ///
  /// This computed property maps each case of `Recurrence` to the number of hours
  /// between doses for that schedule. For example:
  /// - `.hourly` returns `1`
  /// - `.every2Hours` returns `2`
  /// - `.every4Hours` returns `4`
  /// - `.every6Hours` returns `6`
  /// - `.every8Hours` returns `8`
  /// - `.every12Hours` returns `12`
  /// - `.daily` returns `24`
  ///
  /// Use this value when calculating notification schedules, next-dose times,
  /// or converting a recurrence into `DateComponents`/time intervals.
  ///
  /// - Note: The value is always a positive integer representing hours.
  public var intervalInHours: Int {
    switch self {
    case .hourly: return 1
    case .every2Hours: return 2
    case .every4Hours: return 4
    case .every6Hours: return 6
    case .every8Hours: return 8
    case .every12Hours: return 12
    case .daily: return 24
    }
  }
}
