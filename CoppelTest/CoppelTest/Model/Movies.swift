//
//  Movies.swift
//  CoppelTest
//
//  Created by Javier Morales on 27/10/21.
//

import Foundation

struct Movies: Decodable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Movie]?
}

struct Movie: Codable {
    let original_title: String?
    let vote_average: Float?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let adult: Bool?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Float?
    let vote_count: Int?
    let video: Bool?
}

struct TVs: Decodable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Tv]?
}

struct Tv: Decodable {
    let poster_path: String?
    let popularity: Float?
    let id: Int?
    let backdrop_path: String?
    let vote_average: Float?
    let overview: String?
    let first_air_date: String?
    let origin_country: [String]?
    let genre_ids: [Int]?
    let original_language: String?
    let vote_count: Int?
    let name: String?
    let original_name: String
    
}
