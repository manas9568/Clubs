//
//  ClubViewController.swift
//  Club
//
//  Created by GEU on 05/02/26.
//

import UIKit

class ClubViewController: UIViewController {
    

    @IBOutlet var ClubCollectionView: UICollectionView!
    var clubData = ClubsData()
    var ClubsRecommended: [Club] = []
    var ClubsMy: [Club] = []
    var ClubsTrending: [Club] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Clubs"
        ClubsRecommended = clubData.clubs(for: .recommended)
        ClubsMy = clubData.clubs(for: .myClubs)
        ClubsTrending = clubData.clubs(for: .trending)
        print("Loaded clubs: \(ClubsMy.count)")
        // or .myClubs / .trending

        registerCells()
        
        ClubCollectionView.register(UINib(nibName: "SectionHeaderView", bundle:nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "header_view")

        // Do any additional setup after loading the view.
        
        ClubCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
        

        ClubCollectionView.dataSource = self
    }
    
    func registerCells() {
        ClubCollectionView.register(UINib(nibName: "ClubCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "club_cell")
    }

    @IBAction func CreateNewClub(_ sender: Any) {
        performSegue(withIdentifier: "CreateClub", sender: nil)
    }
    
}
extension ClubViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return ClubsMy.count
        }
        if section == 1 {
            return ClubsRecommended.count
        }
        if section == 2{
            return ClubsTrending.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "club_cell", for: indexPath) as! ClubCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 10
            cell.layer.shadowOpacity = 0.5
            let club = ClubsMy[indexPath.item]
            cell.configureCell(club: club)
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "club_cell", for: indexPath) as! ClubCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 10
            cell.layer.shadowOpacity = 0.5
            let club = ClubsRecommended[indexPath.item]
            cell.configureCell(club: club)
            return cell
        }
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "club_cell", for: indexPath) as! ClubCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowRadius = 10
            cell.layer.shadowOpacity = 0.5
            let club = ClubsTrending[indexPath.item]
            cell.configureCell(club: club)
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath)->UICollectionReusableView{
        
        var headerView:SectionHeaderView!
        
        if kind == "header"{
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header_view", for: indexPath) as? SectionHeaderView
            
            if indexPath.section == 0{
                headerView.configure(with: "My Clubs")
            } else if indexPath.section == 1{
                headerView.configure(with: "Recommended")
            }else if indexPath.section == 2{
                headerView.configure(with: "Trending")
            }
        }
        
        headerView.onHeaderButtonTapped = { [weak self] in
               self?.performSegue(
                   withIdentifier: "homeToClubList",
                   sender: indexPath.section
               )
           }
        
        return headerView
    }
    
    func generateLayout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, _) -> NSCollectionLayoutSection? in

            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(55))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .topLeading)

            let section = self.generateClubSection()
            section.boundarySupplementaryItems = [header]
            return section
        }

        return layout
    }

    
        func generateClubSection() -> NSCollectionLayoutSection {

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.60),
                heightDimension: .absolute(220)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                repeatingSubitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 12
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 20,
                bottom: 16,
                trailing: 20
            )
            section.orthogonalScrollingBehavior = .continuous

            return section
        }

    
}


