//
//  DetailRouter.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 29/12/22.
//

import Foundation
import UIKit

class DetailRouter {
    // MARK: - Atributes
    private weak var sourceView: UIViewController?
    private var movie: Movie?
    
    //MARK: - Methods
    func createViewController(with movie: Movie) -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: nil)
        view.movie = movie
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error desconocido") }
        self.sourceView = view
    }
}
