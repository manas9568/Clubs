//
//  ClubListData.swift
//  Club
//
//  Created by Manas  on 07/02/26.
//
import Foundation

class ClubListData: Codable {
    
    var dataList: [ClubList] = [
        ClubList(title: "Fully bOOked", imageName: "Club1"),
        ClubList(title: "Sure Line Mystery", imageName: "Club2"),
        ClubList(title: "Moral Dilemmas", imageName: "Club3"),
        ClubList(title: "HeartFelt Journey", imageName: "Club4"),
        ClubList(title: "Hidden Tides", imageName: "Club5"),
        ClubList(title: "New", imageName: "Club6"),
        ClubList(title: "xcx club", imageName: "Club7"),
        ClubList(title: "welcome!", imageName: "Club8")
    ]
}
