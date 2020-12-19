import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //CV stands for collection view
    private lazy var popularMoviesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor =  .red
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchPopularMovies()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(popularMoviesCV)
        
        
        popularMoviesCV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popularMoviesCV.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        popularMoviesCV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popularMoviesCV.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.25).isActive = true
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
        
        apiClient.getPopularMovies(params: params, completion: {(response) in
            switch response {
            case .success(let popularMovies):
                print(popularMovies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

