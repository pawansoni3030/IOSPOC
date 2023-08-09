//
//  checkboxViewController.swift
//  IOS POC
//
//  Created by Pawan on 09/08/23.
//

import UIKit

class checkboxViewController: UIViewController {
//    class ViewController: UIViewController {

        @IBOutlet weak var tableView: UITableView!

        override func viewDidLoad() {
            super.viewDidLoad()

            // Create an array of checkbox button titles
            let titles = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"]

            // Create an array of checkbox buttons
            let buttons = titles.map { title -> UIButton in
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.setImage(UIImage(systemName: "checkmark"), for: .selected)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                return button
            }

            // Set the data source and delegate of the table view
            tableView.dataSource = self
            tableView.delegate = self

            // Register the checkbox buttons as the table view's cell class
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

            // Set the table view's row count to the number of checkbox buttons
            tableView.rowCount = buttons.count

            // Set the table view's cells to the checkbox buttons
            for (index, button) in buttons.enumerated() {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: index, section: 0))
                cell.contentView.addSubview(button)
                button.frame = cell.contentView.bounds
            }
        }

        @objc func buttonTapped(_ sender: UIButton) {
            // Get the index of the selected button
            let index = tableView.indexPath(for: sender)!.row

            // Toggle the selection of the button
            sender.isSelected = !sender.isSelected

            // Update the table view
            tableView.reloadRows(at: [index], with: .fade)
        }
    }

    extension checkboxViewController: UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return buttons.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = buttons[indexPath.row].titleLabel?.text
            return cell
        }
    }

    extension checkboxViewController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Get the selected button
            let button = buttons[indexPath.row]

            // Toggle the selection of the button
            button.isSelected = !button.isSelected

            // Update the table view
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
