//
//  Item.swift
//  InfiniteListApp
//
//  Created by Nguyen Duc Hoang on 16/07/2022.
//

import Foundation
struct Item:Identifiable, Codable, Equatable {
    var id:Int
    var albumId:Int
    var title:String
    var url:String
    var thumbnailUrl:String
    //implements Equatable protocol
    static func == (itemA: Item, itemB: Item) -> Bool {
        itemA.title == itemB.title &&
        itemA.url == itemB.url &&
        itemA.thumbnailUrl == itemB.thumbnailUrl
    }
}
