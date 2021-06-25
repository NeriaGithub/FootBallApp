//
//  NameCell.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import UIKit




class NameCell: UITableViewCell {

    // MARK:- Properties
    @IBOutlet weak var nameLabel: UILabel!
    var cellVM:CellNameProtocol?{
        didSet{
            if let vm = cellVM{
                nameLabel.text  = vm.cellName
            }
        }
    }
}
