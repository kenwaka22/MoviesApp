//
//  Constants.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 28/12/22.
//

import Foundation

struct Constants {
    
    static let apiKey = Keys.apiKey
    
    struct URL {
//        static let host = "api.themoviedb.org"
//        static let scheme = "https"
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct EndPoints {
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovies = "3/movie/"
    }
}
