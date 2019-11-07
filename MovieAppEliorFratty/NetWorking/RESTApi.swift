

import Foundation

class ApiService: NSObject {
    static let shared = ApiService()
    private override init() {}
    
    let apiKey = "d2b754ada6860b5653029865e4b819a6"

    func fetchMovies(listPage: Int, complition: @escaping ([Movie]) -> ()){
        
        let restApiURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(listPage)"
        
        guard let url = URL(string: restApiURL) else {return}
        var fetchedMovies = [Movie]()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: dataResponse, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    guard let results = parseJSON["results"] as? NSArray else {return}
                    results.forEach({ (dic) in
                        guard let dict = dic as? [String:Any] else {return}
                        guard let movie = Movie(jsonDict: dict) else {return}
                        fetchedMovies.append(movie)
                    })
                    
                    DispatchQueue.main.async {
                        complition(fetchedMovies)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
    }
    
    func fetchMovieDetails(movieId: Int, complition: @escaping (MovieDetailes) -> ()){
        
        let restApiURL = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US"
        
        guard let url = URL(string: restApiURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: dataResponse, options: .mutableContainers) as? [String:Any]
                
                if let parseJSON = json {
                    
                    guard let movieDetails = MovieDetailes(jsonDict: parseJSON) else {return}
                    
                    DispatchQueue.main.async {
                        complition(movieDetails)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
    }

    func fetchSearchedMovies(searchText: String, complition: @escaping ([Movie]) -> ()){
        
        let restApiURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchText)&page=1&include_adult=false"
        
        guard let url = URL(string: restApiURL) else {return}
        var fetchedMovies = [Movie]()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: dataResponse, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    guard let results = parseJSON["results"] as? NSArray else {return}
                    results.forEach({ (dic) in
                        guard let dict = dic as? [String:Any] else {return}
                        guard let movie = Movie(jsonDict: dict) else {return}
                        
                        fetchedMovies.append(movie)
                    })
                    
                    DispatchQueue.main.async {
                        complition(fetchedMovies)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }.resume()
    }
}
