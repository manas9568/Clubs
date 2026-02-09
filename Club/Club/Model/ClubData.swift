//
//  ClubData.swift
//  Club
//
//  Auto-generated from clubs.json structure
//

import Foundation

// MARK: - Main Response
class ClubsData: Codable {

    var clubs: [Club] = []

    init() {
        do {
            let response = try load()
            clubs = response.clubs
        } catch {
            print(error.localizedDescription)
        }
    }

    enum CodingKeys: String, CodingKey {
        case clubs
    }

    func getRandomClub() -> Club {
        return clubs.randomElement()!
    }

    func getClubs(section: ClubSection) -> [Club] {
        return clubs.filter { club in
            club.section == section
        }
    }
}
// MARK: - JSON Loading Helper
extension ClubsData {

    /// Load clubs from a JSON file
    func load(from filename: String = "clubs") throws -> ClubsData {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw NSError(
                domain: "ClubsResponse",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "clubs.json not found"]
            )
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        print(String(data: data, encoding: .utf8))

        do {
            return try decoder.decode(ClubsData.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }

    /// Load clubs from JSON data
    func decode(from data: Data) throws -> ClubsData {
        let decoder = JSONDecoder()
        return try decoder.decode(ClubsData.self, from: data)
    }
}
// MARK: - Filtering Extensions
extension ClubsData {

    func clubs(for section: ClubSection) -> [Club] {
        clubs.filter { $0.section == section }
    }

    func clubs(for category: ClubCategory) -> [Club] {
        clubs.filter { $0.category == category }
    }

    /// Get clubs grouped by section (perfect for UICollectionView)
    var clubsBySection: [ClubSection: [Club]] {
        var grouped: [ClubSection: [Club]] = [:]

        for section in ClubSection.allCases {
            grouped[section] = clubs(for: section)
        }

        return grouped
    }
}
