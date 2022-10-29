//
//  Anime.swift
//  #19 AnimeBook
//
//  Created by Владимир Рубис on 21.10.2022.
//

import Foundation

struct Anime: Decodable {
    var data: [AnimeData]
    
    struct AnimeData: Decodable {
        var title: String
        var images: Image
        
        struct Image: Decodable {
            var jpg: JPG
            
            struct JPG: Decodable {
                var imageUrl: String
                
                enum CodingKeys: String, CodingKey {
                    case imageUrl = "image_url"
                }
            }
        }
    }
}
