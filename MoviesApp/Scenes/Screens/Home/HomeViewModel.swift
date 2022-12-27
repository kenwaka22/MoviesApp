//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 27/12/22.
//

import Foundation

class HomeViewModel {
    private weak var view: HomeView?
    private var router: HomeRouter?
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        
        //Bindear el router con la vista
        self.router?.setSourceView(view)
    }
}
