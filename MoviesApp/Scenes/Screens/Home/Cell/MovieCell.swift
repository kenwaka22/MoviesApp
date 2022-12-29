//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Ken Wakabayashi on 28/12/22.
//

import UIKit

class MovieCell: UITableViewCell {
    //MARK: - Atributes
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    static let reuseIdentifier: String = "MovieCell"
    
    var movie: Movie? {
      didSet {
        configureCell()
      }
    }
    
    //MARK: - Initializers
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Methods
    private func configureCell() {
        guard let movie = self.movie else { return }
        movieTitle.text = movie.title
        movieDescription.text = movie.synopsis
        movieImage.imageFromServerURL(urlString: Constants.URL.urlImages + movie.image, placeHolderImage: UIImage(named: "default") ?? UIImage())
    }
}
