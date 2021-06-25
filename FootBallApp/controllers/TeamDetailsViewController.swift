//
//  TeamdetailsViewController.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 22/06/2021.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    // MARK:- Properies
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var playersTable: UITableView!{
        didSet{
            playersTable.dataSource = self
            playersTable.delegate = self
            playersTable.register(cellType: NameCell.self)
            playersTable.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    var teamVM:TeamDetailsViewModel!
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
   
    // MARK:- View Controller methods
    private func initial(){
        title = teamVM.teamName
        teamVM.fetchLogo()
        teamVM.fetchData()
        binding()
    }
    private func binding() {
        teamVM.playersVM.bind { [weak self](playersVM) in
            if !playersVM.isEmpty{
                self?.tableHeightConstraint =   self?.tableHeightConstraint.changeMultiplier(multiplier: 0.45)
                self?.playersTable.reloadData()
            }
        }
        teamVM.teamImage.bind { [weak self](image) in
            self?.teamLogo.image = image
        }
    }

    // MARK:- Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? MatchesPageViewController,
              let teamID = teamVM.teamID  else { return}
        destination.teamID = teamID
        destination.pageDelegate = self
    }
}

// MARK:- Table View datasource methods
extension TeamDetailsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        teamVM.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamVM.playersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(with: NameCell.self, for: indexPath) 
        cell.cellVM = teamVM.playersAt(indexPath.row)
        return cell
        
        
    }
}

// MARK:- Table View delegate method
extension TeamDetailsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK:- Matches Page View Controller delegate method
extension TeamDetailsViewController:MatchesPageViewControllerDelegate{
    func changeConstraint() {
        containerViewHeightConstraint = containerViewHeightConstraint.changeMultiplier(multiplier: 0.45)
    }
}







