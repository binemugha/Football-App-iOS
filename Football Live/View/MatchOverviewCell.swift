//
//  MatchOverviewCell.swift
//  Football Live
//
//  Created by Benjamin Inemugha on 30/10/2021.
//

import UIKit

class MatchOverviewCell: UITableViewCell {
    
    public static let reuseId = "TodayVCCell"
    
    var awayTeamId: Int?
    var homeTeamId: Int?
    
   
    
    var competitionNameLabel = UILabel()
    
    var scoreLabel = UILabel()
    var homeTeamNameLabel = UILabel()
    var awayTeamNameLabel = UILabel()
    var statusLabel = UILabel()
    
    var parentViewControllerDelegate: UIViewController!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenWidth = UIScreen.main.bounds.width
       
        contentView.frame.size = CGSize(width: screenWidth, height: 100)
        
        
        contentView.addSubview(competitionNameLabel)
        
        competitionNameLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 30)
        competitionNameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        competitionNameLabel.textColor = .lightGray
        competitionNameLabel.textAlignment = .center
        //competitionNameLabel.backgroundColor = .white
        
        contentView.addSubview(scoreLabel)
        scoreLabel.frame.size = CGSize(width: 170, height: 40)
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        scoreLabel.center.x = contentView.center.x
        scoreLabel.center.y = contentView.center.y
        //scoreLabel.backgroundColor = .white
        
        let teamNameLabelsHeight: CGFloat = 40
        let teamNameLabelsFont = UIFont(name: "HelveticaNeue-Medium", size: 12)
        //let teamNameLabelsTextColor: UIColor = .black
        
        contentView.addSubview(homeTeamNameLabel)
        //homeTeamNameLabel.backgroundColor = .white
        //homeTeamNameLabel.textColor = teamNameLabelsTextColor
        homeTeamNameLabel.font = teamNameLabelsFont
        homeTeamNameLabel.frame.size = CGSize(width: screenWidth / 2, height: teamNameLabelsHeight)
        homeTeamNameLabel.center.y += contentView.frame.height - teamNameLabelsHeight
        homeTeamNameLabel.textAlignment = .center
        
        let homeTeamNameLabelTap = UITapGestureRecognizer(target: self, action: #selector(homeTeamNameLabelPressed))
        homeTeamNameLabel.addGestureRecognizer(homeTeamNameLabelTap)
        homeTeamNameLabel.isUserInteractionEnabled = true
        
        contentView.addSubview(awayTeamNameLabel)
        //awayTeamNameLabel.backgroundColor = .white
        //awayTeamNameLabel.textColor = teamNameLabelsTextColor
        awayTeamNameLabel.font = teamNameLabelsFont
        awayTeamNameLabel.frame.size = CGSize(width: screenWidth / 2, height: teamNameLabelsHeight)
        awayTeamNameLabel.center.x += contentView.frame.size.width / 2
        awayTeamNameLabel.center.y += contentView.frame.height - teamNameLabelsHeight
        awayTeamNameLabel.textAlignment = .center
        
        let awayTeamNameLabelTap = UITapGestureRecognizer(target: self, action: #selector(awayTeamNameLabelPressed))
        awayTeamNameLabel.addGestureRecognizer(awayTeamNameLabelTap)
        awayTeamNameLabel.isUserInteractionEnabled = true
        
        let statusLabelHeight = 30
        let statusLabelFont = UIFont(name: "HelveticaNeue-Medium", size: 12)
        let statusLabelOffset = 20
        
        contentView.addSubview(statusLabel)
        //statusLabel.backgroundColor = .white
        statusLabel.frame = CGRect(x: statusLabelOffset, y: Int(contentView.center.y - 25), width: Int(screenWidth / CGFloat(4)), height:  statusLabelHeight)
        statusLabel.textAlignment = .left
        statusLabel.textColor = .lightGray
        statusLabel.font = statusLabelFont
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func homeTeamNameLabelPressed() {
        parentViewControllerDelegate.present(TeamDescriptionVC(teamId: homeTeamId!, teamName: homeTeamNameLabel.text!), animated: true, completion: nil)
    }
    
    @objc
    private func awayTeamNameLabelPressed() {
        parentViewControllerDelegate.present(TeamDescriptionVC(teamId: awayTeamId!, teamName: awayTeamNameLabel.text!), animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

