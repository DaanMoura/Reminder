//
//  HomeViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 04/10/25.
//

import Foundation
import UIKit
import PhotosUI


class HomeViewController: UIViewController {
  let contentView: HomeView
  public weak var flowDelegate: HomeFlowDelegate?
  let viewModel: HomeViewModel
  
  init(contentView: HomeView,
       flowDelegate: HomeFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    self.viewModel = HomeViewModel()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentView.delegate = self
    
    setupBindView()
    setup()
    checkForExistingData()
  }
  
  private func setupBindView() {
    self.view = contentView
  }
  
  private func setup() {
    view.backgroundColor = Colors.gray600
    let backButton = BackBarButtonItem(title: "",
                                       style: .plain,
                                       target: nil,
                                       action: nil)
    navigationItem.backBarButtonItem = backButton
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func setupConstraints() {
    guard self.view !== contentView else { return }
    setupContentViewToBounds(contentView: contentView)
  }
  
  @objc
  private func logoutAction() {
    self.didTapLogoutButton()
  }
  
  private func checkForExistingData() {
    if let userName = UserDefaultsManager.loadUserName() {
      self.contentView.nameTextField.text = userName
    } else {
      self.contentView.nameTextField.placeholder = "home.name.placeholder".localized
    }
    
    if let userImageData = UserDefaultsManager.loadUserProfileImage() {
      self.contentView.profileImage.image = UIImage(data: userImageData)
    } else {
      self.contentView.profileImage.image = UIImage(named: "user")
    }
  }
}

//MARK: Delegate
extension HomeViewController: HomeViewDelegate {
  func didTapLogoutButton() {
    UserDefaultsManager.removeUser()
    UserDefaultsManager.removeUserName()
    UserDefaultsManager.removeUserProfileImage()
    self.flowDelegate?.navigateToSplashScreen()
  }
 
  func didTapProfileImage() {
    self.selectProfileImageDeprecated()
  }
  
  func didTapNewPrescriptionButton() {
    self.flowDelegate?.navigateToNewPrescription()
  }
}

//MARK: Image Picker (deprecated)
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  private func selectProfileImageDeprecated() {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true)
  }
  
  internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let editedImage = info[.editedImage] as? UIImage {
      contentView.profileImage.image = editedImage
      saveImage(image: editedImage)
    } else if let originalImage = info[.originalImage] as? UIImage {
      contentView.profileImage.image = originalImage
      saveImage(image: originalImage)
    }
    
    dismiss(animated: true)
  }
  
  private func saveImage(image: UIImage) {
    if let data = image.pngData() {
      UserDefaultsManager.saveUserProfileImage(img: data)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
}

//MARK: Image Picker
extension HomeViewController: PHPickerViewControllerDelegate  {
  private func selectProfileImage() {
    let imagePicker = PHPickerViewController(configuration: PHPickerConfiguration(photoLibrary: .shared()))
    imagePicker.delegate = self
    present(imagePicker, animated: true)
  }
  
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    // TODO
  }
}

class BackBarButtonItem: UIBarButtonItem {
   override var menu: UIMenu? {
       get { nil }
       set { } // Prevent setting a menu
   }
   }
