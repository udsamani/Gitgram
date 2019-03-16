//
//  FollowCell.swift
//  Gitgram
//
//  Created by Udit Samani on 3/14/19.
//  Copyright © 2019 Udit Samani. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let identifer = "FollowerViewCell"
    
    let bgView = UIView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let noteLabel = UILabel()
    let updateIndicator = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
        self.autoresizesSubviews = true
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.appBackgroundColor
        
        bgView.frame = self.bounds
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.09918129281)
        self.backgroundView = bgView
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.09918129281)
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        let labelStackview = UIStackView()
        labelStackview.translatesAutoresizingMaskIntoConstraints = false
        labelStackview.axis = .vertical
        labelStackview.isBaselineRelativeArrangement = true
        labelStackview.spacing = 21.0
        self.addSubview(labelStackview)
        
        updateIndicator.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        updateIndicator.translatesAutoresizingMaskIntoConstraints = false
        updateIndicator.backgroundColor = UIColor.cyan
        updateIndicator.layer.cornerRadius = 5
        self.addSubview(updateIndicator)
        
        
        nameLabel.textColor = UIColor.white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        labelStackview.addArrangedSubview(nameLabel)
        
        noteLabel.textColor = UIColor.white
        noteLabel.alpha = 0.3
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.numberOfLines=0
        noteLabel.font = noteLabel.font.withSize(14)
        labelStackview.addArrangedSubview(noteLabel)
        
        setupConstraints(labelStackView: labelStackview)
    }
    
    func setupConstraints(labelStackView: UIStackView) {
        let constraints = [
            imageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 54.0),
            imageView.heightAnchor.constraint(equalToConstant: 54.0),
            
            labelStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8.0),
            labelStackView.firstBaselineAnchor.constraint(equalTo: self.topAnchor, constant: 30.0),
            labelStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -4),
            
            updateIndicator.centerYAnchor.constraint(equalTo: noteLabel.centerYAnchor),
            updateIndicator.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -16),
            updateIndicator.widthAnchor.constraint(equalToConstant: 10),
            updateIndicator.heightAnchor.constraint(equalToConstant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    var follower : Follower? {
        didSet {
            guard let aFollower = follower, let followerName = aFollower.name, let imageURL = aFollower.image else { return }
            nameLabel.text = followerName
            noteLabel.text = ""
            
            if let url = URL(string: imageURL) {
                imageView.setImage(from: url)
            }
        }
    }
}
