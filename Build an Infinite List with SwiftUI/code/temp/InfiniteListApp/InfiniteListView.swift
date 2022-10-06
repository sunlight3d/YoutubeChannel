//
//  InfiniteListView.swift
//  InfiniteListApp
//
//  Created by Nguyen Duc Hoang on 25/06/2022.
//

import SwiftUI

struct InfiniteListView: View {
    @ObservedObject var itemRepository:ItemRepository = ItemRepository.shared
    var body: some View {
        ZStack {
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
                        Text(item.title)
                            .font(.title3)
                    }
                    .onAppear {
                        print("\(item.id)-\(item.title)")
                        if item == itemRepository.items.last {
                            print("move to the last, loading more...")
                            Task.init {
                                await itemRepository.getProducts()
                            }
                        }
                    }
                }
            }
            if itemRepository.isLoading {
                HStack {
                    Spacer()
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(Color.primary)
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: 360))
                        .animation(Animation.default.repeatForever(autoreverses: false),value: UUID())
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Task.init {
                await itemRepository.getProducts()
            }
        }
    }
}

struct InfiniteListView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteListView()
    }
}
