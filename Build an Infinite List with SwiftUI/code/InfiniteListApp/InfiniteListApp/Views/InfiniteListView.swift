//
//  InfiniteListView.swift
//  InfiniteListApp
//
//  Created by Nguyen Duc Hoang on 16/07/2022.
//

import SwiftUI

struct InfiniteListView: View {
    @ObservedObject var itemRepository:ItemRepository = ItemRepository.shared
    var body: some View {
        List {
            ForEach(itemRepository.items) { item in
                HStack {
                    AsyncImage(
                        url: URL(string: item.url),
                        content: {
                            $0.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    Text("Row - \(item.title)")
                }
            }
        }
        .onAppear {
            itemRepository.getItems()
        }
        .padding()
        .ignoresSafeArea()
    }
}

struct InfiniteListView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteListView()
    }
}
