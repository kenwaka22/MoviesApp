//
//  Movie.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 28/12/22.
//

import Foundation

struct Movies: Decodable {
    let MoviesList: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case MoviesList = "results"
    }
}

struct Movie: Decodable {
    let title: String
    let popularity: Double
    let movieId: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let synopsis: String
    let releaseDate: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case movieId = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case synopsis = "overview"
        case releaseDate = "release_date"
        case image = "poster_path"
    }
}
