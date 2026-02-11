//
//  Entities.swift
//  Club
//
//  Created by GEU on 05/02/26.
//

import Foundation

// MARK: - Club
struct Club: Codable, Identifiable {
    let id: String?
    let name: String?
    let category: ClubCategory?
    let description: String?
    let imagePath: String?
    let memberCount: Int?
    let language: String?
    let isJoined: Bool?
    let section: ClubSection?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case description
        case imagePath = "image_path"
        case memberCount = "member_count"
        case language
        case isJoined = "is_joined"
        case section
    }
}

struct ClubList: Codable {
    let title: String
    let imageName: String
}


// MARK: - Club Category Enum
enum ClubCategory: String, CaseIterable, Codable {
    case dark
    case poetry
    case classics
    case philosophy
    case fantasy

    var displayName: String {
        switch self {
        case .dark: return "Dark"
        case .poetry: return "Poetry"
        case .classics: return "Classics"
        case .philosophy: return "Philosophy"
        case .fantasy: return "Fantasy"
        }
    }

    var icon: String {
        switch self {
        case .dark: return "🕯️"
        case .poetry: return "📝"
        case .classics: return "📚"
        case .philosophy: return "🏛️"
        case .fantasy: return "🐉"
        }
    }
}

// MARK: - Club Section Enum
enum ClubSection: String, CaseIterable, Codable {
    case myClubs = "my_clubs"
    case recommended
    case trending

    var displayName: String {
        switch self {
        case .myClubs: return "My Clubs"
        case .recommended: return "Recommended"
        case .trending: return "Trending"
        }
    }
}

// Create Club section Enum
enum CreateClubSection: Int, CaseIterable {
    case image
    case name
    case description
    case language
    case genre
    case category
    case privacy
}



