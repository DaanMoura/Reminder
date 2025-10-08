//
//  UserDefaultsManager.swift
//  Reminder
//
//  Created by Daniel Moura on 04/10/25.
//

import Foundation

class UserDefaultsManager {
  private static let userKey = "userKey"
  private static let userNameKey = "userName"
  private static let userProfileImgKey = "userProfileImg"
  
  //MARK: User
  static func saveUser(user: User) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(user) {
      UserDefaults.standard.set(encoded, forKey: userKey)
      UserDefaults.standard.synchronize()
    }
  }
  
  static func loadUser() -> User? {
    if let userData = UserDefaults.standard.data(forKey: userKey) {
      let decoder = JSONDecoder()
      if let user = try? decoder.decode(User.self, from: userData) {
        return user
      }
    }
    return nil
  }
  
  static func removeUser() {
    UserDefaults.standard.removeObject(forKey: userKey)
    UserDefaults.standard.synchronize()
  }
 
  //MARK: User name
  static func saveUserName(name: String) {
      UserDefaults.standard.set(name, forKey: userNameKey)
      UserDefaults.standard.synchronize()
  }
  
  static func loadUserName() -> String? {
    return UserDefaults.standard.string(forKey: userNameKey)
  }
  
  static func removeUserName() {
    UserDefaults.standard.removeObject(forKey: userNameKey)
    UserDefaults.standard.synchronize()
  }
  
  //MARK: Profile image
  static func saveUserProfileImage(img: Data) {
    UserDefaults.standard.set(img, forKey: userProfileImgKey)
    UserDefaults.standard.synchronize()
  }
  
  static func loadUserProfileImage() -> Data? {
    return UserDefaults.standard.data(forKey: userProfileImgKey)
  }
  
  static func removeUserProfileImage() {
    UserDefaults.standard.removeObject(forKey: userProfileImgKey)
    UserDefaults.standard.synchronize()
  }
}
