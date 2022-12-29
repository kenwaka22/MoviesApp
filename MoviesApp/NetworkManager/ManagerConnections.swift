//
//  ManagerConnections.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 28/12/22.
//

import Foundation
import RxSwift

class ManagerConnections {
    
    func getPopularMovies() -> Observable<[Movie]> {
        
        return Observable.create { observer in
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main + Constants.EndPoints.urlListPopularMovies + Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.MoviesList)
                    } catch let error{
                        observer.onError(error)
                        print("Ha ocurrido un error: \(error.localizedDescription)")
                    }
                } else {
                    print("Error")
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDetailMovie() {
        
    }
}
