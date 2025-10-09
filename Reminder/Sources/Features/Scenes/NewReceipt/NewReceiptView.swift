//
//  NewReceiptView.swift
//  Reminder
//
//  Created by Daniel Moura on 09/10/25.
//

import Foundation
import UIKit

class NewReceiptView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.title".localized
    label.font = Typography.heading
    label.textColor = Colors.primaryRedBase
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "newPrescriptions.description.long".localized
    label.numberOfLines = 3
    label.font = Typography.body
    label.textColor = Colors.gray200
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // TODO: formulário
  
  private let addButton: UIButton = {
    let button = UIButton(type: .system)
    let buttonImage = UIImage(systemName: "plus")
    button.setImage(buttonImage, for: .normal)
    button.setTitle("newPrescriptions.add.button.title".localized, for: .normal)
    button.layer.cornerRadius = Metrics.medium
    button.tintColor = Colors.primaryRedBase
    
    button.configuration = .prominentGlass()
    button.configuration?.imagePadding = Metrics.little
    button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
        var outgoing = incoming
        outgoing.font = Typography.subheading
        return outgoing
    }
    button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: Metrics.buttonIconSize, weight: .heavy)

//    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private func setupUI() {
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(addButton)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),

      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.little),
      descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      
      addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
      addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
      addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.tiny),
      addButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight)
    ])
  }
}

