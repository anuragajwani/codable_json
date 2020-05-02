import UIKit

let productsJson = """
                      [
                        {
                          "product_id": 0,
                          "name": "iPhone 11 Clear Case",
                          "price": "38.99"
                        },
                        {
                          "product_id": 1,
                          "name": "Wireless charging pad",
                          "price": "19.99"
                        },
                        {
                          "product_id": 2,
                          "name": "Dual wireless charging pad",
                          "price": "35.99"
                        },
                        {
                          "product_id": 3,
                          "name": "Selfie stick",
                          "price": "14.99"
                        }
                      ]
                   """

struct Product: Decodable {
    let productId: Int
    let name: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name = "name"
        case price = "price"
    }
}

let products = try! JSONDecoder().decode([Product].self, from: productsJson.data(using: .utf8)!)
print(products)

struct ProductQuantity: Encodable {
    let productId: Int
    let quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case quantity = "quantity"
    }
}

struct Order: Encodable {
    let products: [ProductQuantity]
}

let order = Order(products: [ProductQuantity(productId: 1, quantity: 1)])

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let orderJsonData = try! encoder.encode(order)
print(String(data: orderJsonData, encoding: .utf8)!)
