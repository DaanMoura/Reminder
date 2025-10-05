//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 01/10/25.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
  var successResult: ((String) -> Void)?
  var errorResult: ((String) -> Void)?
  
  func doAuth(usernameLogin: String, password: String) {
    Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
      if let error = error {
        self?.errorResult?("Verifique as credenciais digitadas")
      } else {
        self?.successResult?(usernameLogin)
      }
    }
  }
}
