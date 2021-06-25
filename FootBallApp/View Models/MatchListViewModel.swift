//
//  MatchListViewModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 23/06/2021.
//

import Foundation

class MatchListViewModel {
    
    // MARK:- View Model properties
    var matchesVM = Observable<[MatchViewModel]>([])
    var position:Int
    
    init(position:Int) {
        self.position = position
    }
    
    var count: Int {
        matchesVM.value.count
    }
    
    // MARK:- View Model methods
    func matchViewModelAt(position: Int)->MatchViewModel?  {
        if position >= 0 && position < matchesVM.value.count {
            return MatchViewModel(matchDetailModel: matchesVM.value[position].matchDetailModel)
        }
        return nil
    }
    
    func fetchData(teamID:Int) {
        let stringURL = "\(WebService.baseURLString)/teams/\(teamID)/matches\(WebService.getUpcomingMatchesDetailsFilterString())"
        WebService.getRequest(stringURL: stringURL) { [weak self] (result:Result<MatchesModel,WebServiceError>) in
            switch result {
            case .success(let matchesData):
                if let matches = matchesData.matches {
                    let tenMatches = Array(matches.prefix(10))
                    self?.matchesVM.value = tenMatches.compactMap({MatchViewModel(matchDetailModel: $0)})
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}
