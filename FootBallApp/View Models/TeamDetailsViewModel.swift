//
//  TeamViewModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import Foundation
import UIKit.UIImage

class TeamDetailsViewModel{
    
// MARK:- View Model properties
   private let team:TeamDetailModel
   private(set) var playersVM = Observable<[PlayerViewModel]>([])
   private(set) var teamImage = Observable<UIImage?>(nil)
    
    init(_ team: TeamDetailModel) {
        self.team = team
    }
    
    var title: String {
        playersVM.value.count != 0 ? "Team Squad" : ""
    }
    var teamLogo: String {
        return team.crestUrl ?? ""
    }
    var teamName: String {
        team.name ?? ""
    }
    var teamID: Int?{
        team.id
    }
    var playersCount:Int{
        playersVM.value.count
    }
    
    
    // MARK:- View Model methods
    func playersAt(_ index:Int) -> PlayerViewModel {
        playersVM.value[index]
    }
    
     func fetchLogo(){
        WebService.imageLoader(stringURL: teamLogo) { [weak self](result) in
            switch result {
            case .success(let image):
                self?.teamImage.value = image
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func fetchData()  {
        guard let id = teamID else { return  }
        let stringURL = "\(WebService.baseURLString)/teams/\(id)"
        WebService.getRequest(stringURL: stringURL){ [weak self] (result:Result<TeamDetailModel,WebServiceError>) in
            switch result {
            case .success(let team):
                if let squad = team.squad {
                    self?.playersVM.value = squad.compactMap({PlayerViewModel($0)}).filter({$0.role.uppercased() == Constants.playerFilterString.uppercased()})
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

// MARK:- View Model extension
extension TeamDetailsViewModel:CellNameProtocol{
    var cellName: String {
        teamName
    }
    
    
}


