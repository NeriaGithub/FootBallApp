//
//  ViewController.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 21/06/2021.
//

import UIKit
import SVGKit
class ViewController: UIViewController {
    
    // MARK:- Property
   private var teamListVM:TeamListViewModel!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        teamListVM = TeamListViewModel()
        teamListVM.teamsVM.bind {[weak self] (teams) in
            self?.performSegue(withIdentifier: Constants.splashSegue, sender: self)
        }
        teamListVM.fetchData()
    }


    // MARK:- Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.splashSegue {
            guard let navigation = segue.destination as? UINavigationController else { return  }
            guard let destination = navigation.viewControllers.first as? MainViewController else { return  }
            destination.teamListVM = teamListVM
        }
    }
}




