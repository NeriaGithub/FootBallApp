//
//  MainViewController.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK:- Properites
    @IBOutlet weak var teamsTable: UITableView!{
        didSet{
            teamsTable.register(cellType: NameCell.self)
            teamsTable.delegate = self
            teamsTable.dataSource = self
        }
    }
    var teamListVM:TeamListViewModel?
    
  // MARK:- Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.mainSegue {
            guard let selectedIndex = teamsTable.indexPathForSelectedRow?.row,
                  let selectedTeam = teamListVM?.teamAt(selectedIndex),
                 let  _ = selectedTeam.teamID,
                  let destination = segue.destination as? TeamDetailsViewController else { return  }
            destination.teamVM = selectedTeam
        }
    }
}
// MARK:- Table View datasource methods
extension MainViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamListVM?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: NameCell.self, for: indexPath)
        cell.cellVM = teamListVM?.teamAt(indexPath.row)
        return cell
    }
}


// MARK:- Table View delegate methods
extension MainViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.mainSegue, sender: self)
    }
}
