//
//  ItemRepository.swift
//  InfiniteListApp
//
//  Created by Nguyen Duc Hoang on 16/07/2022.
//

import Foundation
class ItemRepository: ObservableObject {
    public static let SERVER = "jsonplaceholder.typicode.com"
    private func urlGetProducts(startIndex:Int, limit:Int) -> String {
            "https://\(ItemRepository.SERVER)/photos?_start=\(startIndex)&_limit=\(limit)"
        }
    
    static let shared = ItemRepository()
    @Published var items: [Item] = [] //Observable data
    @Published var isLoading = false //Observable data
    func getItems() {
        isLoading = true
        items = [
            Item(id: 1, albumId: 2, title: "haha11",
                 url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Kittyply_edit1.jpg/640px-Kittyply_edit1.jpg", thumbnailUrl: ""),
            Item(id: 2, albumId: 2, title: "haha 2233",
                 url: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Domestic_Cat_Face_Shot.jpg/320px-Domestic_Cat_Face_Shot.jpg", thumbnailUrl: ""),
            Item(id: 3, albumId: 2, title: "haha 4455",
                 url: "https://upload.wikimedia.org/wikipedia/commons/d/da/Cat_tongue_macro.jpg", thumbnailUrl: ""),
            Item(id: 4, albumId: 2, title: "haha 4455",
                 url: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Holland_lop.JPG/320px-Holland_lop.JPG", thumbnailUrl: "")
        ]
    }
}
