//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 26/09/25.
//

import Foundation
import UIKit

//MARK: View Controller
class LoginBottomSheetViewController: UIViewController {
  let viewModel = LoginBottomSheetViewModel()
  var handleAreaHeight: CGFloat = 50.0
  
  let contentView: LoginBottomSheetView
  public weak var flowDelegate: LoginBottomSheetFlowDelegate?
  
  init(contentView: LoginBottomSheetView,
       flowDelegate: LoginBottomSheetFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentView.delegate = self
    setupUI()
    setupGesture()
    bindViewModel()
  }
  
  private func setupUI() {
    self.view.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
    
//    let heightConstraint: () = loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
      contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
  }
  
  private func bindViewModel() {
    viewModel.successResult = { [weak self] usernameLogin in
      self?.presentSaveLoginAlert(email: usernameLogin)
    }
    
    viewModel.errorResult = { [weak self] errorMessage in
      self?.presentErrorAlert(message: errorMessage)
    }
  }
  
  private func presentErrorAlert(message: String) {
    let alertController = UIAlertController(title: "Erro ao logar",
                                            message: message,
                                            preferredStyle: .alert)
    
    let retryAction = UIAlertAction(title: "Tentar novamente",
                                 style: .default)
    
    alertController.addAction(retryAction)
    self.present(alertController, animated: true)
  }
  
  private func presentSaveLoginAlert(email: String) {
    let alertController = UIAlertController(title: "Salvar acesso",
                                            message: "Deseja se manter conectado?",
                                            preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Salvar",
                                   style: .default) { _ in
      let user = User(email: email, isUserSaved: true)
      UserDefaultsManager.saveUser(user: user)
      self.flowDelegate?.navigateToHome()
    }
    
    let cancelAction = UIAlertAction(title: "Cancelar",
                                     style: .cancel) { _ in
      self.flowDelegate?.navigateToHome()
    }
    
    alertController.addAction(saveAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true)
  }
  
  private func setupGesture() {
    // TODO
  }
  
  private func handlePanGesture() {
    // TODO
  }
  
  func animateShow(completion: (() -> Void)? = nil) {
    self.view.layoutIfNeeded()
    contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
    UIView.animate(withDuration: 0.3, animations: {
      self.contentView.transform = .identity
      self.view.layoutIfNeeded()
    }) { _ in
      completion?()
    }
  }
}

//MARK: Delegate
extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
  func sendLoginData(user: String, password: String) {
    viewModel.doAuth(usernameLogin: user, password: password)
  }
}
