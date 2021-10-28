//
//  ProfileApiRes.swift
//  CoppelTest
//
//  Created by Javier Morales on 27/10/21.
//

import Foundation


struct ProfileResponse: Decodable {
    let success: Bool
    let session_id: String
}


struct Profile: Decodable {
    let avatar: Avatar?
    let id: Int?
    let iso_639_1: String?
    let iso_3166_1: String?
    let name: String?
    let include_adult: Bool?
    let username: String?
}

struct Avatar: Decodable {
    let gravatar: Gravatar?
    let tmdb: Tmdb?
}

struct Gravatar: Decodable {
    let hash: String?
}

struct Tmdb: Decodable {
    let avatar_path: String?
}

