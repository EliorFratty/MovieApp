


import UIKit

class MovieViewController: UIViewController {
    
    //MARK: - Properties
    private var movies = [Movie]()
    private let cellID = "movieCell"
    private var searchedMovie = [Movie]()
    private var searching = false
    private var pageNumber = 1
    private var isLoading = false

    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        
        return sb
    }()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(MovieCell.self, forCellReuseIdentifier: cellID)
        tb.rowHeight = 80
        tb.keyboardDismissMode = .onDrag
      // tb.isPagingEnabled = true
        
        return tb
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubviews(searchBar, tableView)
        configurateSearchBar()
        loadItemsNow(listPage: pageNumber)

    }
    
    //MARK: - Configurations
    
    func configurateSearchBar() {
    
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: view.frame.width, height: 50))
        
        tableView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    
    func loadItemsNow(listPage: Int){
        if isLoading { return }
      
        isLoading = true
        ApiService.shared.fetchMovies(listPage: listPage) { [self] (fetchedMovie) in
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.movies += fetchedMovie
                self.tableView.reloadData()
            }
        }
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchedMovie.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MovieCell
        
        var myMovie: Movie!
        
        if searching {
            myMovie = searchedMovie[indexPath.row]
        } else {
            myMovie = movies[indexPath.row]
        }
        
        cell.movie = myMovie

        if indexPath.row == movies.count - 1 && // last cell
            pageNumber < 5 {
            
            pageNumber += 1
                loadItemsNow(listPage: pageNumber)
                print(movies.count)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let id: Int
        
        if searching {
            id = searchedMovie[indexPath.row].id
        } else {
            id = movies[indexPath.row].id
        }

        ApiService.shared.fetchMovieDetails(movieId: id) { (movieDetails) in
            let mvcc = movieVCViewController()
            mvcc.movieDetail = movieDetails
            
            self.navigationController?.pushViewController(mvcc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pageNumber = 1
        self.searching = true
        ApiService.shared.fetchSearchedMovies(searchText: searchText) { [self] (fetchedMovies) in
           self.searchedMovie = fetchedMovies
            self.tableView.reloadData()
        }
        
        if searchText == "" {
            searching = false
            tableView.reloadData()
        } else {
            self.searching = true
        }
    }
}

