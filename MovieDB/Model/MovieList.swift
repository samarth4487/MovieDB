//
//  MovieList.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import Foundation
import Alamofire


struct Movie: Decodable {
    
    let page: Int
    let results: [Result]?
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page = "page", results = "results", totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page) ?? 0
        results = try values.decodeIfPresent([Result].self, forKey: .results)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
    }
    
    static func getMovies(withPage page: Int, _ callback: @escaping (Movie?, Bool, String) -> Void) {
        /*
         It'll call the generic method in APIClient to download the required data
        */
        
        let url = URL(string: GlobalConstants.BASE_URL + "/now_playing?api_key=\(GlobalConstants.API_KEY)&page=\(page)&language=en-US")
        APIClient.makeRequest(withURL: url!) { (movie: Movie?, error: Bool, errorMessage: String)  in
            if !error {
                guard let movie = movie else { return }
                callback(movie, error, errorMessage)
            } else {
                callback(nil, error, errorMessage)
            }
        }
    }
    
    static func modifyDateString(withString dateString: String) -> String {
        /*
         Converts 2019-03-29 to March 29, 2019.
        */
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = "LLLL d, yyyy"
        return dateFormatter.string(from: date)
    }
}


struct Result: Decodable {
    
    let title: String
    let posterPath: String
    let releaseDate: String
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case title = "title", releaseDate = "release_date", posterPath = "poster_path", id = "id"
    }
    
    init(title: String, posterPath: String = "", releaseDate: String = "", id: Int = 1) {
        /*
         For test cases.
        */
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
    }
}
