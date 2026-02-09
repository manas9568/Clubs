//
//  MyClubsViewController.swift
//  Club
//
//  Created by Manas  on 07/02/26.
//

import UIKit

class MyClubsViewController: UIViewController {
    
    var clubdata = ClubsData()
    var club: [Club] = []
    
    struct ClubList: Codable {
        let title: String
        let imageName: String
        let description: String
        let theme: String
    }

    var dataList: [ClubList] = [
        ClubList(title: "Fully bOOked", imageName: "Club1", description: "asfs alsfjlf aslfjsf alskfjslf alsfjsf", theme: "Dark"),
        ClubList(title: "Sure Line Mystery", imageName: "Club2", description: "A space for book lovers to share thoughts, quotes, and weekend reads.", theme: "Light"),
        ClubList(title: "Moral Dilemmas", imageName: "Club3", description: "Exploring magical realms and deep mysteries.", theme: "Thriller"),
        ClubList(title: "HeartFelt Journey", imageName: "Club4", description: "Delving into the depths of guilt, redemption, and moral conflict", theme: "Romance"),
        ClubList(title: "HeartFelt Journey", imageName: "Club3", description: "Delving into the depths of guilt, redemption, and moral conflict", theme: "Romance"),
        ClubList(title: "HeartFelt Journey", imageName: "Club1", description: "Delving into the depths of guilt, redemption, and moral conflict", theme: "Romance")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        club = clubdata.clubs(for: .myClubs)
        
        title = "My Clubs"

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

}
extension MyClubsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return club.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.iconimageView.image = UIImage(named: club[indexPath.row].imagePath)
        cell.iconimageView.layer.cornerRadius = 24
        cell.titlelabel.text = club[indexPath.row].name
        cell.desc.text = club[indexPath.row].description
        cell.genre.text = club[indexPath.row].category.displayName
        
        //giving shadow and radius to the view
        cell.view.layer.cornerRadius = 24
        cell.view.layer.masksToBounds = false
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.18
//        cell.layer.shadowOffset = CGSize(width: 0, height: 6)
//        cell.layer.shadowRadius = 12
//        cell.layer.shadowPath = UIBezierPath(
//            roundedRect: cell.bounds,
//            cornerRadius: 16
//        ).cgPath
        
        return cell
    }
}
extension MyClubsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
}
