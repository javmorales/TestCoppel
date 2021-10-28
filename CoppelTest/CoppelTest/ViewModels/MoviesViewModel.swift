//
//  MoviesModel.swift
//  CoppelTest
//
//  Created by Javier Morales on 27/10/21.
//

import Foundation


class MoviesViewModel {
    
    var refreshData = { () -> () in }
    
    var dataArray: [Movie] = [] {
        didSet {
            refreshData()
        }
    }
    
    var dataArrayTvs: [Tv] = [] {
        didSet {
            refreshData()
        }
    }
    
    func retrieveDataList(category: String = "popular", tvOrMovie: String = "movie", params: [String: Any]?) {
                
        let baseURLv3 = "https://api.themoviedb.org/3"
        let api_key = "9e41694ddf2f504b03d4441d4b85e851"
        
        guard let url = URL(string: "\(baseURLv3)/\(tvOrMovie)/\(category)?api_key=\(api_key)&language=en-US&page=1") else { return }
        
        if tvOrMovie == "movie" {
            ApiService.makeRequestReturnGeneric(url: url, method: .GET, parameters: params) { (movies: Movies) in
                self.dataArray.removeAll()
                self.dataArray = movies.results ?? [Movie]()
            }
        } else {
            ApiService.makeRequestReturnGeneric(url: url, method: .GET, parameters: params) { (tvs: TVs) in
                self.dataArrayTvs.removeAll()
                self.dataArrayTvs = tvs.results ?? [Tv]()
            }
        }
    }
}
