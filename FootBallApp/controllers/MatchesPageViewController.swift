//
//  MatchesPageViewController.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 23/06/2021.
//

import UIKit



class MatchesPageViewController: UIPageViewController {
    
    // MARK:- Properties
    var teamID:Int?
   private var matchesListVM:MatchListViewModel!
    weak var pageDelegate:MatchesPageViewControllerDelegate?
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    // MARK:- Page View Controller  methods
    private func initial()  {
        dataSource = self
        matchesListVM = MatchListViewModel(position: 0)
        matchesListVM.fetchData(teamID: teamID  ?? 0)
        binding()
    }
    
    private func binding() {
        matchesListVM.matchesVM.bind {[weak self] (matchesList) in
            if !matchesList.isEmpty{
                self?.pageDelegate?.changeConstraint()
                if let destination = self?.buildSecondController(position: 0) {
                    self?.setViewControllers([destination], direction: .forward, animated: true, completion: nil)
                }
            }
        }
    }
    
    private  func buildSecondController(position: Int) -> MatchDetailViewController? {
        guard let destination = storyboard?.instantiateViewController(identifier: Constants.matchDetailStoryBoardID) as?  MatchDetailViewController,
              let matchDetailVM = matchesListVM.matchViewModelAt(position: position) else { return nil }
        destination.position = position
        destination.matchDetailVM = matchDetailVM
        return destination
    }
}

private  func setup() {
    let  appearance = UIPageControl.appearance(whenContainedInInstancesOf: [MatchesPageViewController.self])
    appearance.pageIndicatorTintColor = .lightGray
    appearance.currentPageIndicatorTintColor = .white
}

// MARK:- Page View Controller datasource methods
extension MatchesPageViewController:UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let prevDestination = viewController as? MatchDetailViewController {
            return buildSecondController(position: prevDestination.position - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let prevDestination = viewController as? MatchDetailViewController {
            return buildSecondController(position: prevDestination.position + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setup()
        return matchesListVM.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

