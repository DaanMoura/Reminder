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
    guard let initialDate = formatter.date(from: prescription.time) else {
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
    
    
//    let initialComponents = calendar.dateComponents([.hour, .minute], from: initialDate)
//    
//    let trigger = UNCalendarNotificationTrigger(
//      dateMatching: initialComponents,
//      repeats: true
//    )
//    
//    let request = UNNotificationRequest(
//      identifier: String(prescription.id),
//      content: content,
//      trigger: trigger
//    )
//    
//    center.add(request) { error in
//      if let error = error {
//        print("Erro ao agendar notificações \(error)")
//      } else {
//        print("Notificação para \(prescription.medicine) criada com sucesso!")
//      }
//    }
  }

}
