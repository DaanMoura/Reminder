//
//  LoginBottomSheetViewDelegate.swift
//  Reminder
//
//  Created by Daniel Moura on 30/09/25.
//

import Foundation
import UIKit

protocol LoginBottomSheetViewDelegate: AnyObject {
  func sendLoginData(user: String, password: String) 
}
