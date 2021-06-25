//
//  PlayerViewModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import Foundation

class PlayerViewModel{
    
    // MARK:- View Model properties
   private let player:PlayerModel
    init(_ player:PlayerModel) {
        self.player = player
    }
    var name: String {
        player.name ?? ""
    }
    var role: String {
        player.role ?? ""
    }
}

// MARK:- View Model extension
extension PlayerViewModel:CellNameProtocol{
    var cellName: String {
         name
    }
    
}
