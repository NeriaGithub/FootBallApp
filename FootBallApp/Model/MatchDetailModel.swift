//
//  MatchDetailModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 24/06/2021.
//

import Foundation

struct MatchDetailModel:Codable {
    let competition:CompetitionModel?
    let date:String?
    let homeTeam:MatchDetailTeamModel?
    let awayTeam:MatchDetailTeamModel?
    private enum CodingKeys:String,CodingKey{
        case competition, date = "utcDate",homeTeam,awayTeam
    }
}
