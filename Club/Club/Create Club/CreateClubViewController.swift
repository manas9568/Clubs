//
//  CreateClubViewController.swift
//  Club
//
//  Created by Manas  on 06/02/26.
//

import UIKit

// MARK: - Protocol (must be declared at file scope, not inside a class)
protocol CreateClubDelegate: AnyObject {
    func didCreateClub(_ club: Club)
}

class CreateClubViewController: UIViewController {

    // Closure for passing new club back to ClubViewController
    var onCreateClub: ((Club) -> Void)?

    @IBOutlet weak var TableView: UITableView!
    let sections = CreateClubSection.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        TableView.dataSource = self
        TableView.delegate = self

        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 80

        // Wire the Done button if not already connected in storyboard
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(doneTapped)
    }

    // MARK: - Done Button Action
    @objc func doneTapped() {
        // Read values from the table view cells
        let clubName = textFieldValue(inSection: .name) ?? "New Club"
        let clubDescription = textFieldValue(inSection: .description) ?? ""
        let clubLanguage = textFieldValue(inSection: .language) ?? "English"

        let newClub = Club(
            id: UUID().uuidString,
            name: clubName,
            category: .classics,
            description: clubDescription,
            imagePath: "Club1",
            memberCount: 1,
            language: clubLanguage,
            isJoined: true,
            section: .myClubs
        )

        onCreateClub?(newClub)
        dismiss(animated: true)
    }

    /// Helper: reads the text field value from a prototype cell at the given section
    private func textFieldValue(inSection section: CreateClubSection) -> String? {
        guard let sectionIndex = sections.firstIndex(of: section) else { return nil }
        let indexPath = IndexPath(row: 0, section: sectionIndex)
        guard let cell = TableView.cellForRow(at: indexPath) else { return nil }

        // Find the first UITextField in the cell's contentView
        for subview in cell.contentView.subviews {
            if let textField = subview as? UITextField, let text = textField.text, !text.isEmpty {
                return text
            }
        }
        return nil
    }
}

// MARK: - UITableViewDataSource
extension CreateClubViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            return cell
        case .name:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TextFieldCell",
                for: indexPath
            )
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TextViewCell",
                for: indexPath
            )
            return cell
        case .language, .genre, .category:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "PickerCell",
                for: indexPath
            )
            cell.accessoryType = .disclosureIndicator
            return cell
        case .privacy:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SwitchCell",
                for: indexPath
            )
            return cell
        }
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {

        let sectionType = sections[section]

        switch sectionType {
        case .image:       return "Add Image"
        case .name:        return "Name"
        case .description: return "Description"
        case .language:    return "Language"
        case .genre:       return "Genre"
        case .category:    return "Category"
        case .privacy:     return "Club Privacy"
        }
    }
}

// MARK: - UITableViewDelegate
extension CreateClubViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let section = sections[indexPath.section]

        switch section {
        case .language:
            print("Open language picker")
        case .genre:
            print("Open genre picker")
        case .category:
            print("Open category picker")
        default:
            break
        }
    }
}
