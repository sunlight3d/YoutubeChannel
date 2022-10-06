//
//  Item.swift
//  InfiniteListApp
//
//  Created by Nguyen Duc Hoang on 21/06/2022.
//

import Foundation
import Foundation
//"albumId": 1,
//    "id": 1,
//    "title": "accusamus beatae ad facilis cum similique qui sunt",
//    "url": "https://via.placeholder.com/600/92c952",
//    "thumbnailUrl": "https://via.placeholder.com/150/92c952"

struct Item:Identifiable, Codable, Equatable {
    var id:Int
    var albumId:Int
    var title:String
    var url:String
    var thumbnailUrl:String
    
    static func == (itemA: Item, itemB: Item) -> Bool {
        itemA.title == itemB.title &&
        itemA.url == itemB.url &&
        itemA.thumbnailUrl == itemB.thumbnailUrl
    }
     
}
