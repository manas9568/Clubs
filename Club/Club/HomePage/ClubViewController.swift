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
        navigationController?.navigationBar.prefersLargeTitles = true

        ClubsRecommended = clubData.clubs(for: .recommended)
        ClubsMy = clubData.clubs(for: .myClubs)
        ClubsTrending = clubData.clubs(for: .trending)

        registerCells()

        ClubCollectionView.register(
            UINib(nibName: "SectionHeaderView", bundle: nil),
            forSupplementaryViewOfKind: "header",
            withReuseIdentifier: "header_view"
        )

        ClubCollectionView.setCollectionViewLayout(generateLayout(), animated: false)
        ClubCollectionView.dataSource = self
        ClubCollectionView.backgroundColor = .systemBackground
    }

    func registerCells() {
        ClubCollectionView.register(
            UINib(nibName: "ClubCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "club_cell"
        )
    }

    @IBAction func CreateNewClub(_ sender: Any) {
        performSegue(withIdentifier: "CreateClub", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateClub",
           let nav = segue.destination as? UINavigationController,
           let createVC = nav.topViewController as? CreateClubViewController {

            createVC.onCreateClub = { [weak self] newClub in
                guard let self = self else { return }
                self.ClubsMy.insert(newClub, at: 0)
                self.ClubCollectionView.performBatchUpdates {
                    self.ClubCollectionView.insertItems(
                        at: [IndexPath(item: 0, section: 0)]
                    )
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ClubViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return ClubsMy.count
        case 1: return ClubsRecommended.count
        case 2: return ClubsTrending.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "club_cell", for: indexPath) as! ClubCollectionViewCell

        let club: Club
        switch indexPath.section {
        case 0:  club = ClubsMy[indexPath.item]
        case 1:  club = ClubsRecommended[indexPath.item]
        case 2:  club = ClubsTrending[indexPath.item]
        default: return UICollectionViewCell()
        }

        cell.configureCell(club: club)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                         viewForSupplementaryElementOfKind kind: String,
                         at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header_view",
            for: indexPath
        ) as! SectionHeaderView

        switch indexPath.section {
        case 0:
            headerView.configure(with: "My Clubs", count: ClubsMy.count)
        case 1:
            headerView.configure(with: "Recommended")
        case 2:
            headerView.configure(with: "Trending")
        default:
            break
        }

        headerView.onHeaderButtonTapped = { [weak self] in
            self?.performSegue(
                withIdentifier: "homeToClubList",
                sender: indexPath.section
            )
        }

        return headerView
    }
}

// MARK: - Compositional Layout
extension ClubViewController {

    func generateLayout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            guard let self = self else { return nil }

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: "header",
                alignment: .topLeading
            )

            switch sectionIndex {
            case 0:
                // My Clubs — horizontal scrolling
                let section = self.generateHorizontalSection()
                section.boundarySupplementaryItems = [header]
                return section
            default:
                // Recommended & Trending — 2-column vertical grid
                let section = self.generateGridSection()
                section.boundarySupplementaryItems = [header]
                return section
            }
        }

        return layout
    }

    /// Section 0: Horizontal scrolling cards
    func generateHorizontalSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(211),
            heightDimension: .absolute(270)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 1
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 14
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 16, bottom: 20, trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    /// Sections 1 & 2: 2-column vertical grid
    func generateGridSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(211),
            heightDimension: .absolute(270)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 1
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 14
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 16, bottom: 20, trailing: 16
        )
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
}
