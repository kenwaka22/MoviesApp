//
//  HomeView.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 27/12/22.
//

import UIKit
import RxSwift

class HomeView: UIViewController {
    
    //MARK: - Atributes
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.bind(view: self, router: router)
        activity.startAnimating()
        getData()
    }
    
    //MARK: - Methods
    private func getData() {
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
}

//MARK: - Delegates
extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { fatalError("Unable to dequeue MovieCell") }
        
                
        cell.movie = movies[indexPath.row]        
        return cell
    }
}

//MARK: - DataSource
extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}



