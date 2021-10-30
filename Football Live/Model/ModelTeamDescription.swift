//
//  ModelTeamDescription.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import Foundation

struct ModelTeamDescription: Codable {
    let id: Int?
    let name: String?
    let activeCompetitions: [ModelActiveCompetition]?
    let shortName: String?
    let website: String?
    let crestUrl: String?
    let squad: [ModelPlayer]?
    let lastUpdated: String?
}
