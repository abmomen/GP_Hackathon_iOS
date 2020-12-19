import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private var popularMovies: PopularMovies?
    private var trendingMovies: TrendingVideos?
    
    //CV stands for collection view
    private lazy var popularMoviesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        fetchPopularMovies()
        fetchTrendingMovies()
    }
    
    private func setupCollectionView() {
        view.backgroundColor = .white
        view.addSubview(popularMoviesCV)
        
        popularMoviesCV.collectionViewLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 5
            return flowLayout
        }()
        
        popularMoviesCV.delegate = self
        popularMoviesCV.dataSource = self
        popularMoviesCV.register(PopularMovieCell.self, forCellWithReuseIdentifier: "PopularMovieCell")
        popularMoviesCV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popularMoviesCV.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        popularMoviesCV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popularMoviesCV.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.25).isActive = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(TrendingMoviesCell.self, forCellReuseIdentifier: "TrendingMoviesCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: popularMoviesCV.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func getPopularMovie(index: Int) -> Movies? {
        guard let popularMovies = self.popularMovies else {
            return nil
        }
        return popularMovies.results[index]
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularMovies?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCell", for: indexPath) as? PopularMovieCell else
        { return UICollectionViewCell() }
        
        cell.configure(movie: getPopularMovie(index: indexPath.row))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingMovies?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingMoviesCell", for: indexPath) as? TrendingMoviesCell else
        { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
}


//MARK:- API_Calls
extension ViewController {
    private func fetchPopularMovies() {
        let apiClient = APIClient()
        var params: Parameters = [:]
        params[Constants.apiKey] = "1a97f3b8d5deee1d649c0025f3acf75c"
        params[Constants.primaryReleaseYear] = "2020"
        params[Constants.sortBy] = "vote_average.desc"
        
        apiClient.getPopularMovies(params: params, completion: {[weak self] (response) in
            switch response {
            case .success(let popularMovies):
                self?.popularMovies = popularMovies
                self?.popularMoviesCV.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func fetchTrendingMovies() {
        let apiClient = APIClient()
        var params: Parameters = [:]
        params[Constants.apiKey] = "1a97f3b8d5deee1d649c0025f3acf75c"
        
        apiClient.getTrendingVideos(params: params, completion: {[weak self] (response) in
            switch response {
            case .success(let popularMovies):
                self?.trendingMovies = popularMovies
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

