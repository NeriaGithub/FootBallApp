//
//  MainViewModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import Foundation

class TeamListViewModel {
    
    // MARK:- View Model properties
   private(set) var teamsVM = Observable<[TeamDetailsViewModel]>([])
    var count: Int {
       return teamsVM.value.count
    }
    
    // MARK:- View Model Methods
    func fetchData(){
        let stringURL = "\(WebService.baseURLString)/teams\(WebService.getAreasFilterString())"
        WebService.getRequest(stringURL: stringURL) { [weak self](result:Result<FootBallModel,WebServiceError>) in
            switch result {
            case .success(let footballData):
                if let teams = footballData.teams {
                    self?.teamsVM.value = teams.compactMap({TeamDetailsViewModel($0)})
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func teamAt(_ index:Int) -> TeamDetailsViewModel {
        return teamsVM.value[index]
    }
}



