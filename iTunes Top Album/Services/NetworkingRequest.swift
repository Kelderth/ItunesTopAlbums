//
//  NetworkingRequest.swift
//  iTunes Top Album
//
//  Created by Jesus Sanchez on 12/13/18.
//  Copyright © 2018 Jesus Sanchez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias TopAlbumSuccess = ([Album]) -> ()
typealias TopAlbumFailure = () -> ()

class NetworkingRequest {
    var success: TopAlbumSuccess!
    var failure: TopAlbumFailure!
    
    func downloadiTunes(_ count: String) {
        
        let urlString = "http://itunes.apple.com/us/rss/topalbums/limit=" + count + "/json"
        
        guard let url = URL(string: urlString) else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                let numberOfEntries = json["feed"]["entry"].count

                var albumTopList: [Album] = [Album]()
                
//                print("numberOfEntries: \(numberOfEntries)")
                for numberOfEntry in 0 ..< numberOfEntries {
                    let defaultDirectory = json["feed"]["entry"][numberOfEntry]
                    let albumName = defaultDirectory["im:name"]["label"].string!
                    let artistName = defaultDirectory["im:artist"]["label"].string!
                    let albumImage = defaultDirectory["im:image"][2]["label"].string!
                    let albumCategory = defaultDirectory["category"]["attributes"]["term"].string!
                    let albumReleaseDate = defaultDirectory["im:releaseDate"]["label"].string!
                    let albumPrice = defaultDirectory["im:price"]["label"].string!
                    let favorited = false
                    albumTopList.append(Album(albumName: albumName, artistName: artistName, albumeImage: albumImage, albumCategory: albumCategory, albumReleaseDate: albumReleaseDate, albumPrice: albumPrice, isFavorited: favorited))
//                    self.creatingTopAmbumFrom()
                    
                }
//                print(albumTopList)
                self.success?(albumTopList)
            case .failure(let error):
                print(error)
//                print("Hola")
                self.failure?()
            }
            
        }
//        print(urlString)
        
    }
    
    func iTunesAlbumImage(_ imageUrl: String, completion: @escaping (Data)->()) {
        
        guard let urlImage = URL(string: imageUrl) else { return }
        
        Alamofire.request(urlImage).response { (dataResponse) in
            
            guard let data = dataResponse.data else { return }
//            print("this is data: ", data)
            completion(data)
        }
        
//        print(imageUrl)
        
    }
    
}
