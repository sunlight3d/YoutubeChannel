//https://jsonplaceholder.typicode.com/photos?_start=10&_limit=5
import Foundation
enum ItemStatus: Equatable {
    case initial, success
    case failure(message:String)
}
class ItemRepository:ObservableObject {
    public static let SERVER = "jsonplaceholder.typicode.com"
    private func urlGetProducts(startIndex:Int, limit:Int) -> String {
        "https://\(ItemRepository.SERVER)/photos?_start=\(startIndex)&_limit=\(limit)"
    }
    static let shared = ItemRepository()
    @Published var items: [Item] = []
    @Published var isLoading = false
    private var hasReachedMax = false
    private var itemStatus:ItemStatus = .initial
    
    func getProducts(limit:Int = 10) async {
        isLoading = true
        if hasReachedMax == true {
            isLoading = false
            return
        }
        if itemStatus == ItemStatus.initial {
            let responseProducts = await self.fetchItems(startIndex: 0,limit: limit)
            DispatchQueue.main.async {
                self.items = self.items + responseProducts
                self.isLoading = false
                self.itemStatus = .success
            }            
        } else {
            let responseProducts = await self.fetchItems(startIndex: items.count, limit: limit)
            DispatchQueue.main.async {
                if responseProducts.isEmpty {
                    self.hasReachedMax = true
                } else {
                    self.items = self.items + responseProducts
                    self.itemStatus = .success
                    self.hasReachedMax = false
                }
                self.isLoading = false
            }
            
            
        }
        
    }
    private func fetchItems(startIndex:Int, limit:Int) async -> [Item]{
        do {
            guard let url = URL(string: urlGetProducts(startIndex: startIndex, limit: limit)) else {
                isLoading = false
                itemStatus = .failure(message: "Invalid url")
                return []
            }
            let sharedSession = URLSession.shared
            let (data, response) = try await sharedSession.data(from: url, delegate: nil)
            return try JSONDecoder().decode([Item].self, from: data)
            
        }catch {
            print(error)
            return []
        }
    }
}

