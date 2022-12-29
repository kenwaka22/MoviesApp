//
//  Extensions.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 28/12/22.
//

import UIKit

extension UIImageView {
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage){
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) {data, response, error in
            if error != nil {
                self.image = placeHolderImage
                return
            }

            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
