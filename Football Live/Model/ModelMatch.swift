//
//  ModelMatch.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import Foundation

struct ModelMatch: Codable {
    let id: Int?
    let competition: ModelCompetition?
    let homeTeam: ModelTeamDescription?
    let awayTeam: ModelTeamDescription?
    let score: ModelScore?
    let status: String?
    let utcDate: String?
}
