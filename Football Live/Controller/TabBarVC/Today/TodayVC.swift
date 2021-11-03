//
//  TodayVC.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import UIKit

class TodayVC: UIViewController {
    
    var tableView: UITableView!
    let activityView = UIActivityIndicatorView(style: .large)
    
    var matches = [ModelMatch]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Today"
        tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        
        view.backgroundColor = .green
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpTableView()
        loadMatchesOverviewAndUpdateTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(activityView)
    }
    
    private func loadMatchesOverviewAndUpdateTableView() {
        self.activityView.startAnimating()
        let groupLoadMatches = DispatchGroup()
        groupLoadMatches.enter()
        NetworkManager.shared.getTodayMatches { (result) in
            switch result {
            case .success(let response):
                self.matches = response.matches!
                groupLoadMatches.leave()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        groupLoadMatches.notify(queue: DispatchQueue.main) {
            self.activityView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func setUpTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        tableView.register(MatchOverviewCell.self, forCellReuseIdentifier: MatchOverviewCell.reuseId)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
}

extension TodayVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchOverviewCell.reuseId, for: indexPath) as! MatchOverviewCell
        cell.selectionStyle = .none
        
        
        let match = matches[indexPath.row]
        
        guard let awayTeamId = match.awayTeam?.id else { return cell }
        guard let homeTeamId = match.homeTeam?.id else { return cell }
        
        guard let homeTeamName = match.homeTeam?.name else { return cell }
        guard let awayTeamName = match.awayTeam?.name else { return cell }
        
        guard let matchStatus = match.status else { return cell }
        guard let matchCompetitionName = match.competition?.name else { return cell}
        
        cell.awayTeamId = awayTeamId
        cell.homeTeamId = homeTeamId
        
        cell.homeTeamNameLabel.text = homeTeamName
        cell.awayTeamNameLabel.text = awayTeamName
        
        cell.competitionNameLabel.text = matchCompetitionName.uppercased()
        cell.statusLabel.text = (matchStatus == "IN_PLAY" ? "LIVE" : matchStatus)
        
        cell.statusLabel.textColor = UIColor.colorForMatchStatus(match.status!)
        cell.parentViewControllerDelegate = self
        
        guard let homeTeamScore = match.score?.fullTime?.homeTeam,
            let awayTeamScore = match.score?.fullTime?.awayTeam else {
                cell.scoreLabel.text = "-:-"
                return cell
        }
        
        cell.scoreLabel.text = "\(homeTeamScore):\(awayTeamScore)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TodayVC: UITableViewDelegate { }

