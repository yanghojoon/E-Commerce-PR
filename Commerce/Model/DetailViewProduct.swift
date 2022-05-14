import Foundation

struct DetailViewProduct: Codable {
    let id: Int
    let vendorId: Int
    let name: String
    let description: String
    let thumbnail: String
    let currency: Currency
    let price: Double
    let bargainPrice: Double
    let discountedPrice: Double
    let stock: Int
    let images: [ProductImage]
    let vendor: Vendor?
    let createdAt: Date
    let issuedAt: Date
    
    struct Vendor: Codable { // 추가기능 구현 시 활용 예정
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, vendorId, name, description, thumbnail, currency, price, bargainPrice,
             discountedPrice, stock, images, createdAt, issuedAt
        
        case vendor = "vendors"
    }
}
