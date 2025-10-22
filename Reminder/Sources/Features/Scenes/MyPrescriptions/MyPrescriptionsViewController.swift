//
//  MyPrescriptionsViewController.swift
//  Reminder
//
//  Created by Daniel Moura on 14/10/25.
//

import Foundation
import UIKit

class MyPrescriptionsViewController: UIViewController {
  private let contentView: MyPrescriptionsView
  private let viewModel = MyPrescriptionsViewModel()
  private weak var flowDelegate: MyPrescriptionsFlowDelegate?
  
  private var prescriptions: [Prescription] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentView.delegate = self
    setupView()
    loadData()
  }
  
  private func setupView() {
    view.backgroundColor = Colors.gray600
    view.addSubview(contentView)
    
    setupConstraints()
    setupNavigationBar()
    setupTableView()
  }
  
  private func setupNavigationBar() {
    let addPrescriptionButton = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addPrescriptionButtonTapped)
    )
    addPrescriptionButton.tintColor = Colors.primaryBlueBase
    addPrescriptionButton.style = .prominent
    navigationItem.rightBarButtonItem = addPrescriptionButton
  }
  
  private func setupConstraints() {
    guard self.view !== contentView else { return }
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupTableView() {
    contentView.tableView.dataSource = self
    contentView.tableView.delegate = self
    contentView.tableView.register(PrescriptionCell.self, forCellReuseIdentifier: PrescriptionCell.identifier)
    contentView.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
  }

  init(contentView: MyPrescriptionsView, flowDelegate: MyPrescriptionsFlowDelegate) {
    self.contentView = contentView
    self.flowDelegate = flowDelegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc
  private func addPrescriptionButtonTapped() {
    
  }
  
  private func loadData() {
    prescriptions = viewModel.fetchData()
  }
}

extension MyPrescriptionsViewController: MyPrescriptionsViewDelegate {}

extension MyPrescriptionsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionCell.identifier, for: indexPath) as! PrescriptionCell
    let prescription = prescriptions[indexPath.section]
    cell.configure(prescription: prescription)
    return cell
  }
}

extension MyPrescriptionsViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return prescriptions.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = .clear
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 4
  }
  
}

