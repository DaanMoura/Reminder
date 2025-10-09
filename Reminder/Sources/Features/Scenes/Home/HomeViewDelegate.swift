//
//  HomeViewDelegate.swift
//  Reminder
//
//  Created by Daniel Moura on 06/10/25.
//

import Foundation

public protocol HomeViewDelegate: AnyObject {
  func didTapLogoutButton()
  func didTapProfileImage()
  func didTapNewPrescriptionButton()
}
