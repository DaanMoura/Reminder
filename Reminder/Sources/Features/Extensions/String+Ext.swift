//
//  String+Ext.swift
//  Reminder
//
//  Created by Daniel Moura on 29/09/25.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
