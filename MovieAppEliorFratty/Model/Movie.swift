
import UIKit

struct Movie {
    let id: Int
    let title: String
    let popularity: Double
    let poster: String
    let startingUrlForImage = "https://image.tmdb.org/t/p/w500"
    
    init?(jsonDict: [String: Any]) {
        
         let id         = jsonDict["id"]          as? Int ?? 0
         let title      = jsonDict["title"]       as? String ?? ""
         let popularity = jsonDict["popularity"]  as? Double ?? 0
         let poster     = jsonDict["poster_path"] as? String ?? ""
        
        self.id         = id
        self.title      = title
        self.popularity = popularity
        self.poster     = startingUrlForImage + poster
    }
}
