//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Daniel Moura on 01/10/25.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
  func doAuth(usernameLogin: String, password: String) {
    Auth.auth().signIn(withEmail: usernameLogin, password: password) { [weak self] authResult, error in
      if let error = error {
        print("Autenticação não foi com sucesso: \(error)")
      } else {
        print(authResult, "Sucesso na autenticação")
      }
    }
  }
}
