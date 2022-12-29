//
//  DetailView.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 29/12/22.
//

import UIKit
import RxSwift

class DetailView: UIViewController {
    
    //MARK: - Atributes
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieSynopsis: UILabel!
    @IBOutlet private weak var movieHomePage: UILabel!
    @IBOutlet private weak var movieScore: UILabel!
    @IBOutlet private weak var movieReleaseDate: UILabel!
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    var movie: Movie?
    {
        didSet {
            displayMovieDetail()
        }
    }
    var movieDetail: MovieDetail?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }
    
    //MARK: - Methods
    private func configureBindings() {
        viewModel.bind(view: self, router: router)
    }
    
    private func reloadInfo() {
        guard let movie = movieDetail else { return }
        DispatchQueue.main.async {
            self.movieTitle.text = movie.title
            self.movieImage.imageFromServerURL(urlString: Constants.URL.urlImages + movie.image, placeHolderImage: UIImage(named: "default") ?? UIImage())
            self.movieSynopsis.text = movie.synopsis
            self.movieHomePage.text = movie.homePage
            self.movieScore.text = String(movie.voteAverage)
            self.movieReleaseDate.text = movie.releaseDate
        }
    }
    
    private func displayMovieDetail() {
        guard let movieId = movie?.movieId else { return }
        return viewModel.getMovieDetail(movieId: String(movieId))
        //Manejar la concurrencia o hilos en Rx
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        
        //Subscribir la vista al observable
            .subscribe { [weak self] movie in
                self?.movieDetail = movie
                self?.reloadInfo()
            } onError: { error in
                print(error.localizedDescription)
            } onCompleted: {}
            .disposed(by: disposeBag)
        //Dar por completado la secuencia Rx
    }
}
