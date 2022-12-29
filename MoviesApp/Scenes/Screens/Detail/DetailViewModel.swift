//
//  DetailViewModel.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 29/12/22.
//

import Foundation
import RxSwift

class DetailViewModel {
    private weak var view: DetailView?
    private var router: DetailRouter?
    private var managerConnections = ManagerConnections()
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        
        //Bindear el router con la vista
        self.router?.setSourceView(view)
    }
    
    func getMovieDetail(movieId: String) -> Observable<MovieDetail> {
        return managerConnections.getDetailMovie(from: movieId)
    }
}
