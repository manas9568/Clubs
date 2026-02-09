//
//  CreateClubViewController.swift
//  Club
//
//  Created by Manas  on 06/02/26.
//

import UIKit

class CreateClubViewController: UIViewController {
    @IBOutlet weak var TableView : UITableView!
    let sections = CreateClubSection.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate = self
        // Do any additional setup after loading the view.
        
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 80

    }
}
//extension CreateClubViewController : UITableViewDataSource,UITableViewDelegate{
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 7
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Tapped!!!")
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "hahaha"
//        return cell
//    }
//}

extension CreateClubViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section{
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
        case .image: return "Add Image"
        case .name: return "Name"
        case .description: return "Description"
        case .language: return "Language"
        case .genre: return "Genre"
        case .category: return "Category"
        case .privacy: return "Club Privacy"
        }
    }

}
extension CreateClubViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

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

