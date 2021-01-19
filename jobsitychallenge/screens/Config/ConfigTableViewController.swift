//
//  ConfigTableViewController.swift
//  jobsitychallenge
//
//  Created by Rafael Freitas on 18/01/21.
//

import UIKit

class ConfigTableViewController: UITableViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    // MARK: - View Setup

    private func config() {
        viewSetup()
        navigationSetup()
    }

    private func viewSetup() {
        self.tableView.backgroundColor = UIColor(named: Constants.background)
        self.view.backgroundColor = UIColor(named: Constants.background)
        self.tableView.separatorStyle = .none
    }

    // MARK: - Navigation SetUp

    private func navigationSetup() {
        self.navigationItem.title = "Configuration"
    }

    // MARK: - Methods

    private func askUserToCreateAPin(cell: UISwitchTableViewCell) {
        var field: UITextField?

        let alert = UIAlertController(
            title: "Create a pin",
            message: "Next time you open the application it will be secure by the pin you entered",
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: "Save", style: .default) { _ in
            UserDefaults.standard.set(true, forKey: "hasPassword")
            UserDefaults.standard.set(field?.text, forKey: "pin")
            self.dismiss(animated: true)
        }

        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { _ in
            cell.switcher.isOn = false
            UserDefaults.standard.set(false, forKey: "hasPassword")
            self.dismiss(animated: true)
        }

        alert.addAction(cancelAction)
        alert.addAction(action)

        alert.addTextField { (alertTextField) in
            alertTextField.isSecureTextEntry = true
            alertTextField.keyboardType = .numberPad
            field = alertTextField
        }
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - TableView Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.configurationCellIdentifier) as? UISwitchTableViewCell ?? UISwitchTableViewCell()
        cell.titleLabel.text = "Ask for pin to unlock"
        cell.didChangeSwitchValue = {
            UserDefaults.standard.set(cell.switcher.isOn, forKey: "hasPassword")
            if cell.switcher.isOn {
                self.askUserToCreateAPin(cell: cell)
            }
        }
        return cell
    }
}
