//
//  Game.swift
//  GamerGuru
//
//  Created by Nilton Pontes on 01/10/24.
//

import Foundation

struct Game: Identifiable, Codable {
    let name: String?
    var cover: Int?
    var coverUrl: String?
    let id: Int?
    let url: String?
    let screenshots: [Int]?
    let summary: String?
    let platforms: [Int]?
    let genres: [Int]?
}
