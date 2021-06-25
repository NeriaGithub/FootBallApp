//
//  TeamDetailModel.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 24/06/2021.
//

import Foundation

struct TeamDetailModel:Codable{
    var id:Int?
    var name:String?
    var crestUrl:String?
    var squad:[PlayerModel]?
}
