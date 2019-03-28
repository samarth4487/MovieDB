//
//  APIClient.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static func makeRequest<T: Decodable>(withURL url: URL, _ callback: @escaping (T?, Bool, String) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            (response) in
            
            guard let responseData = response.data else { return }
            
            do {
                
                let responseObject = try JSONDecoder().decode(T.self, from: responseData)
                guard let response = response.response else { return }
                let statusCode = response.statusCode
                
                switch statusCode {
                    
                case GlobalConstants.API_RESPONSE_CODE_SUCCESS:
                    callback(responseObject, false, "")
                    
                case GlobalConstants.API_RESPONSE_CODE_NO_INTERNET:
                    callback(nil, true, GlobalConstants.NO_INTERNET_MESSAGE)
                    
                case GlobalConstants.API_RESPONSE_CODE_INTERNAL_SERVER_ERROR:
                    callback(nil, true, GlobalConstants.SOMETHING_WENT_WRONG_MESSAGE)
                    
                case GlobalConstants.API_RESPONSE_CODE_BAD_REQUEST:
                    callback(nil, true, GlobalConstants.BAD_REQUEST_MESSAGE)
                    
                default:
                    callback(nil, true, GlobalConstants.SOMETHING_WENT_WRONG_MESSAGE)
                }
                
            } catch {
                callback(nil, true, GlobalConstants.FAILED_TO_PARSE_JSON_MESSAGE)
            }
        }
    }
    
    static func downloadImage(_ url: String, original: Bool, andCallback callback: @escaping (UIImage) -> Void) {
        
        Alamofire.request(original ? GlobalConstants.ORIGINAL_IMAGE_PREFIX : GlobalConstants.SMALL_IMAGE_PREFIX + url)
            .response() {
                dataResponse in
                
                let data = dataResponse.data
                
                if let imageData = data {
                    if let downloadedImage = UIImage(data: imageData) {
                        callback(downloadedImage)
                    }
                }
        }
    }
}
