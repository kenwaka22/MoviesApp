//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 27/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
    
    //MARK: - Atributes
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    //UI
    private lazy var searchController: UISearchController = {
        let element = UISearchController(searchResultsController: nil)
        element.hidesNavigationBarDuringPresentation = true
        element.obscuresBackgroundDuringPresentation = false
        element.searchBar.sizeToFit()
        element.searchBar.barStyle = .default
        element.searchBar.backgroundColor = .clear
        element.searchBar.placeholder = "Search a movie"
        return element
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        configureNavigationBar()
        configureTableView()
        configureActivity()
        displayMovies()
        configureSearchBarController()
    }
    
    //MARK: - Methods
    private func configureBindings() {
        viewModel.bind(view: self, router: router)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "MovieApp"
    }
    
    private func configureActivity() {
        activity.startAnimating()
    }
    
    private func displayMovies() {
        return viewModel.getMoviesList()
        //Manejar la concurrencia o hilos en Rx
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        
        //Subscribir la vista al observable
            .subscribe { [weak self] movies in
                self?.movies = movies
                self?.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {}
            .disposed(by: disposeBag)
        //Dar por completado la secuencia Rx
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        print(MovieCell.self)
        print(MovieCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func configureSearchBarController(){
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { result in
                self.filteredMovies = self.movies.filter({ movie in
                    return movie.title.contains(result)
                })
                self.reloadTableView()
            })
            .disposed(by: disposeBag)
    }
}

//MARK: - TableView Delegates
extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { fatalError("Unable to dequeue MovieCell") }
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.movie = filteredMovies[indexPath.row]
        } else {
            cell.movie = movies[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var movie: Movie
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        viewModel.showDetailView(movie: movie)
    }
}

//MARK: - TableView DataSource
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: - Search Delegate
extension HomeView: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableView()
    }
}





