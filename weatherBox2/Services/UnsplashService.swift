//
//  UnsplashService.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 26/04/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class UnsplashService {

    private var searchResult: [UnsplashPhoto] = []
    private var photoIndex: Int = 0
    private var totalPhotos: Int = 0
    
    init() {
        
    }
    
    public func getPhotoList(with tags: [String], completion: @escaping([UnsplashPhoto]?, Error?) -> Void) {
        let urlString = getUnsplashApiSearchURL(for: tags)
        let request = AF.request(urlString)

        request.responseDecodable(of: [UnsplashPhoto].self) { (response) in
            guard let result = response.value else {
                completion(nil, response.error)
                return
            }
            
            self.searchResult = result
            self.photoIndex = 0
            self.totalPhotos = result.count
            
            completion(result, nil)
        }
    }
    
    public func getPhoto(completion: @escaping(UnsplashPhoto?, Error?) -> Void) {
        if photoIndex == totalPhotos {
            getPhotoList(with: Season.getTags(for: Season.getSeason())) { (list, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let list = list else {
                    completion(nil, error)
                    return
                }
                
                self.searchResult = list
                self.photoIndex = 0
                self.totalPhotos = list.count
                
                completion(list[0], nil)
            }
        }
        else {
            completion(searchResult[photoIndex], nil)
            photoIndex += 1
        }
    }
    
    private func getUnsplashApiSearchURL(for queries: [String]) -> URL {
        var url = "\(API_UNSPLASH_COM_SEARCH)"
        if queries.count == 0 {
            return URL(string: url)!
        }
        
        for x in 0..<queries.count {
            if x == 0 {
                url = "\(url)\(queries[x])"
            }
            else {
                url = "\(url),\(queries[x])"
            }
        }
        
        return URL(string: url)!
    }
}
