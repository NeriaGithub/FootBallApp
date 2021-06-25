//
//  MatchViewModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 23/06/2021.
//

import Foundation

class MatchViewModel {
    
    // MARK:- View Model properties
    let matchDetailModel:MatchDetailModel
    
    init(matchDetailModel:MatchDetailModel) {
        self.matchDetailModel = matchDetailModel
    }
    
    var match: String {
        "\(matchDetailModel.homeTeam?.name ?? "") VS \(matchDetailModel.awayTeam?.name ?? "")"
    }
    var league: String {
        matchDetailModel.competition?.name ?? ""
    }
    
    var date: String {
        guard let date = DateUtils.shared.convertStringToDate(dateString: matchDetailModel.date ?? "", dateFormat: .apiFormat),
            let dateString = DateUtils.shared.convertDateToString(date: date, dateFormat: .startWithDay)
              else { return "" }
        return dateString
    }
}
