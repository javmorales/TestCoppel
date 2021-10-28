//
//  MovieSubclassedCollectionViewCell.swift
//  CoppelTest
//
//  Created by Javier Morales on 27/10/21.
//


import UIKit

class SubclassedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseMovieLabel: UILabel!
    @IBOutlet weak var imageScore: UIImageView!
    @IBOutlet weak var scoreMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    
    
    var movie: Movie? {
        didSet {
            imageMovie.downloaded(from: "https://www.themoviedb.org/t/p/w500\(movie?.poster_path ?? "")")
            titleMovieLabel.text = movie?.original_title ?? ""
            releaseMovieLabel.text = movie?.release_date ?? ""
            scoreMovieLabel.text = "\(movie?.vote_average ?? 0.0)"
            overviewMovieLabel.text = movie?.overview ?? ""
        }
    }
    
    var tv: Tv? {
        didSet {
            titleMovieLabel.text = tv?.original_name ?? ""
            releaseMovieLabel.text = tv?.first_air_date ?? ""
            scoreMovieLabel.text = "\(tv?.vote_average ?? 0.0)"
            overviewMovieLabel.text = tv?.overview ?? "No overview"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell(colour: .black)
    }
    
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
    }
}
