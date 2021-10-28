//
//  ProfileViewModel.swift
//  CoppelTest
//
//  Created by Javier Morales on 27/10/21.
//

import Foundation



class ProfileViewModel {
    
    var refreshData = { () -> () in }

    var dataArrayProfile: [Tv] = [] {
        didSet {
            refreshData()
        }
    }
    
    var profiel: [Profile] = [] {
        didSet {
            refreshData()
        }
    }
    
    
    func getInformationUser() {
        let baseURLv3 = "https://api.themoviedb.org/3"
        let api_key = "9e41694ddf2f504b03d4441d4b85e851"
        
        guard let url = URL(string: "\(baseURLv3)/authentication/session/new?api_key=\(api_key)") else { return }
         
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        
        let params = [ "request_token": token ]
        
        ApiService.makeRequestReturnGeneric(url: url, method: .POST, parameters: params) { (profileResponse: ProfileResponse) in
            
            if profileResponse.success {
                
                let urlStringAccount = "\(baseURLv3)/account?api_key=\(api_key)&session_id=\(profileResponse.session_id)"
                guard let urlAccount = URL(string: urlStringAccount) else { return }
                
                ApiService.makeRequestReturnGeneric(url: urlAccount, method: .GET, parameters: nil) { (profile: Profile)in
                    
                    self.profiel.removeAll()
                    
                    self.profiel.append(Profile(avatar: profile.avatar, id: profile.id, iso_639_1: profile.iso_3166_1, iso_3166_1: profile.iso_639_1, name: profile.name, include_adult: profile.include_adult, username: profile.username))
                    
                    let stringUrl = "\(baseURLv3)/account/\(profileResponse.session_id)/favorite/tv?api_key=\(api_key)&language=en-US&sort_by=created_at.asc&page=1"
                    guard let urlStringShowsFavorites = URL(string: stringUrl) else { return }
                    let params = [
                        "account_id": profile.id ?? 0
                    ] as [String : Any]
                    
                    ApiService.makeRequestReturnGeneric(url: urlStringShowsFavorites, method: .GET, parameters: params ) { (showsFavorites: TVs) in
                        self.dataArrayProfile.removeAll()
                        self.dataArrayProfile = showsFavorites.results ?? [Tv]()
                    }
                }
                
            }
        }
        
    }
    
    
    
    
}
