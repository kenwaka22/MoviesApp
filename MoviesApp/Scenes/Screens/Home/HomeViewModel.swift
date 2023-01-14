//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 27/12/22.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerConnections = ManagerConnections()
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        
        //Bindear el router con la vista
        self.router?.setSourceView(view)
    }
    
    func getMoviesList() -> Observable<[Movie]> {
        return managerConnections.getPopularMovies()
    }
    
    func showDetailView(movie: Movie) {
        router?.navigateToDetailView(movie: movie)
    }
    
    //PRUEBA
    func prueba() {
    }
}
