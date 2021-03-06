//
//  SearchTeamVC.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import UIKit

class SearchTeamVC: UIViewController {
    
    static public var shared = SearchTeamVC()
    
    private init() {
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    var searchBar = UISearchBar()
    var tableView = UITableView()
    
    var allTeams = [ModelTeamDescription]()
    var searchedTeams = [ModelTeamDescription]()
    
    var parentVCDelegate: FavoritesVC!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        
        loadAllTeams()
        setupSearchBar()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(activityView)
    }
    
    func loadAllTeams() {
        self.activityView.startAnimating()
        let groupLoadTeams = DispatchGroup()
        groupLoadTeams.enter()
        NetworkManager.shared.getTeamsFromArea(area: .Europe) { (result) in
            switch result {
            case .success(let response):
                if let teams = response.teams {
                    for team in teams {
                        self.allTeams.append(team)
                        
                    }
                    print("Number of teams are ", self.allTeams.count)
                    groupLoadTeams.leave()
                }
            case .failure(let error):
                print(error)
            }
        }
        groupLoadTeams.notify(queue: DispatchQueue.main) {
            self.allTeams.sort { (team1, team2) -> Bool in
                return team1.name! < team2.name!
            }
            self.filterTeams()
            self.activityView.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search team..."
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func filterTeams() {
        searchedTeams.removeAll()
        for team in self.allTeams {
            if (team.name?.lowercased().contains(searchBar.text!.lowercased()))! {
                searchedTeams.append(team)
            }
        }
    }
}

extension SearchTeamVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterTeams()
        tableView.reloadData()
    }
}

extension SearchTeamVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedTeams.count == 0 && searchBar.text == "" {
            return allTeams.count
        }
        return searchedTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if searchedTeams.count == 0 && searchBar.text == "" {
            cell.textLabel?.text = allTeams[indexPath.row].name
        } else {
            cell.textLabel?.text = searchedTeams[indexPath.row].name
        }
        for team in parentVCDelegate.savedFavoritesTeams {
            if String(describing: team.value(forKey: "name")!) == cell.textLabel?.text {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteTeam: ModelTeamDescription!
        if searchedTeams.isEmpty {
            favoriteTeam = allTeams[indexPath.row]
        } else {
            favoriteTeam = searchedTeams[indexPath.row]
        }
        if let cell = self.tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                dismiss(animated: true, completion: nil)
                return
            }
        }
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        searchBar.text = ""
        self.filterTeams()
        self.tableView.reloadData()
        parentVCDelegate.addFavoriteTeam(teamId: favoriteTeam.id!, teamName: favoriteTeam.name!)
        parentVCDelegate.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension SearchTeamVC: UITableViewDelegate { }

extension SearchTeamVC: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

