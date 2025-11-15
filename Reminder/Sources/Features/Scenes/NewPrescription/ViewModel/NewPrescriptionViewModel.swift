//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 11/10/25.
//

import Foundation
import UserNotifications

class NewPrescriptionViewModel {
  func addPrescription(prescription: Prescription) {
//    var finalTime = prescription.time
//    if prescription.takeNow {
//      let date = Date()
//    }
    DBHelper.shared.insertPrescription(prescription: prescription)
    scheduleNotifications(prescription: prescription)
  }

  private func scheduleNotifications(prescription: Prescription) {
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "Hora de tomar o remédio"
    content.body = "Lembre-se de tomar \(prescription.medicine)"
    content.sound = .default
    
    let interval = prescription.recurrence.intervalInHours
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    var finalTime = prescription.time
    finalTime = formatter.string(from: Date())
    
    guard let initialDate = formatter.date(from: finalTime) else {
      return
    }
    
    let calendar = Calendar.current
    var currentDate = initialDate
    
    for i in 0..<(24 / interval) {
      let components = calendar.dateComponents([.hour, .minute], from: currentDate)
      
      let trigger = UNCalendarNotificationTrigger(
        dateMatching: components,
        repeats: true
      )
      
      let request = UNNotificationRequest(
        identifier: String(prescription.id) + "_\(i)",
        content: content,
        trigger: trigger
      )
      
      center.add(request) { error in
        if let error = error {
          print("Erro ao agendar notificação \(error)")
        } else {
          print("Notificação para \(prescription.medicine) criada com sucesso!")
        }
      }
      
      currentDate = calendar.date(byAdding: .hour, value: interval, to: currentDate) ?? Date()
    }
  }

}
