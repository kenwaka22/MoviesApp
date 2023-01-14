//
//  HomeRouter.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 27/12/22.
//

import Foundation
import UIKit

class HomeRouter {
    private weak var sourceView: UIViewController?
    
    func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }
    
    func navigateToDetailView(movie: Movie) {
        //let detailView = DetailRouter().createViewController(with: movie)
        let vc = DetailRouter().createViewController(with: movie)
        sourceView?.navigationController?.pushViewController(vc, animated: true)
//        let detailView = DetailView()
//        sourceView?.navigationController?.pushViewController(detailView, animated: true)

    }
}
