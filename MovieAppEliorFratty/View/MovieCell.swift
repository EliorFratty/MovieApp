//
//  TableViewCell.swift
//  KaduregelStats
//
//  Created by User on 06/11/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    let profileImageViewHeight:CGFloat = 48
    
    var movie: Movie? {
        didSet{
            if let movie = movie {
                textLabel?.text = movie.title
                detailTextLabel?.text = "Popularity: \(String(movie.popularity))"
                profileImageView.loadImageUsingCatchWithUrlString(URLString: movie.poster)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y-2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y+2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = profileImageViewHeight/2
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageAnchor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func profileImageAnchor() {
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8) .isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
    }
}

class indicatorCell: UITableViewCell {
    
    let indicator: UIActivityIndicatorView = {
       let ind = UIActivityIndicatorView()
        
        return ind
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(indicator)
        indicator.centerInSuperview(size: CGSize(width: 40, height: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
