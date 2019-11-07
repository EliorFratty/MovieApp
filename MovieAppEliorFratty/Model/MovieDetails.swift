//
//  MovieDetails.swift
//  KaduregelStats
//
//  Created by User on 06/11/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

struct MovieDetailes {
    let title : String
    let posterPath: String
    let realeaseDate: String
    let overView: String
    let gender: String
    let voteAvg: Double
    
    private let startingUrlForImage = "https://image.tmdb.org/t/p/w500"

    init?(jsonDict: [String: Any]) {
        
        let overView       = jsonDict["overview"]      as? String ?? ""
        let title          = jsonDict["title"]         as? String ?? ""
        let realeaseDate   = jsonDict["release_date"] as? String ?? ""
        let posterPath     = jsonDict["poster_path"]   as? String ?? ""
        let voteAvg        = jsonDict["vote_average"]  as? Double ?? 0
        
        var gender = ""
        let genres = jsonDict["genres"] as! NSArray
        genres.forEach { (gen ) in
            let gens = gen as! [String: Any]
            gender += "\(gens["name"] as! String), "
        }
        
        gender.removeLast()
        gender.removeLast()
        
        self.overView     = overView
        self.title        = title
        self.realeaseDate = realeaseDate
        self.posterPath   = startingUrlForImage + posterPath
        self.gender       = gender
        self.voteAvg      = voteAvg
    }
}
