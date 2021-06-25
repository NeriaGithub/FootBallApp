//
//  ClassNameProtocol.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 25/06/2021.
//

import Foundation

protocol ClassNameProtocol {
   static var className: String { get }
}

extension ClassNameProtocol {
   static var className: String {
       return String(describing: self)
   }
}

extension NSObject: ClassNameProtocol {}

