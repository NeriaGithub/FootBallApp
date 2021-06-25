//
//  MatchDetailViewController.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 23/06/2021.
//

import UIKit

class MatchDetailViewController: UIViewController {

    // MARK:- Properties
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var position:Int = 0
    var matchDetailVM:MatchViewModel?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    
   // MARK:- View Controller method
  private  func initial() {
    guard let VM = matchDetailVM else { return }
    matchLabel.text = VM.match
    leagueLabel.text = VM.league
    dateLabel.text = VM.date
    }
}
