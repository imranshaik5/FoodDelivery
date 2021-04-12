//
//  HomeModel.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import Foundation
import UIKit
struct ProductDetails {
    var image = UIImage()
    var name = String()
    var mainDescription = String()
    var subDescription = String()
    var backgroundColor = UIColor()
    init(image: UIImage, name:String, mainDescription:String, subDescription:String,backgroundColor:UIColor) {
        self.image = image
        self.name = name
        self.mainDescription = mainDescription
        self.subDescription = subDescription
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Welcome
struct HomeModel: Codable {
    let location: Location
    let popularity: Popularity
    let link: String
    let nearby_restaurants: [Nearby_restaurants]
    
//    var location : Location?
    //    var popularity : Popularity?
    //    var link : String?
    //    var nearby_restaurants : [Nearby_restaurants]?

    enum CodingKeys: String, CodingKey {
        case location, popularity, link
        case nearby_restaurants = "nearby_restaurants"
    }
}

// MARK: - WelcomeLocation
struct Location: Codable {
    let entityType: String
    let entityID: Int
    let title, latitude, longitude: String
    let cityID: Int
    let cityName: String
    let countryID: Int
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case entityType = "entity_type"
        case entityID = "entity_id"
        case title, latitude, longitude
        case cityID = "city_id"
        case cityName = "city_name"
        case countryID = "country_id"
        case countryName = "country_name"
    }
}

// MARK: - NearbyRestaurant
struct Nearby_restaurants: Codable {
    let restaurant: Restaurant
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let r: R
    let apikey, id, name: String
    let url: String
    let location: RestaurantLocation
    let switchToOrderMenu: Int
    let cuisines: String
    let average_cost_for_two, priceRange: Int
    let currency: String
    let offers: [JSONAny]
    let opentableSupport, isZomatoBookRes: Int
    let mezzoProvider: String
    let isBookFormWebView: Int
    let bookFormWebViewURL, bookAgainURL: String
    let thumb: String
    let userRating: UserRating
    let photosURL, menuURL: String
    let featuredImage: String
    let medioProvider: Bool
    let hasOnlineDelivery, isDeliveringNow: Int
    let storeType: String
    let includeBogoOffers: Bool
    let deeplink: String
    let orderURL: String?
    let orderDeeplink: String?
    let isTableReservationSupported, hasTableBooking: Int
    let eventsURL: String
    let bookURL: String?

    enum CodingKeys: String, CodingKey {
        case r = "R"
        case apikey, id, name, url, location
        case switchToOrderMenu = "switch_to_order_menu"
        case cuisines
        case average_cost_for_two = "average_cost_for_two"
        case priceRange = "price_range"
        case currency, offers
        case opentableSupport = "opentable_support"
        case isZomatoBookRes = "is_zomato_book_res"
        case mezzoProvider = "mezzo_provider"
        case isBookFormWebView = "is_book_form_web_view"
        case bookFormWebViewURL = "book_form_web_view_url"
        case bookAgainURL = "book_again_url"
        case thumb
        case userRating = "user_rating"
        case photosURL = "photos_url"
        case menuURL = "menu_url"
        case featuredImage = "featured_image"
        case medioProvider = "medio_provider"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case storeType = "store_type"
        case includeBogoOffers = "include_bogo_offers"
        case deeplink
        case orderURL = "order_url"
        case orderDeeplink = "order_deeplink"
        case isTableReservationSupported = "is_table_reservation_supported"
        case hasTableBooking = "has_table_booking"
        case eventsURL = "events_url"
        case bookURL = "book_url"
    }
}

// MARK: - RestaurantLocation
struct RestaurantLocation: Codable {
    let address, locality, city: String
    let cityID: Int
    let latitude, longitude, zipcode: String
    let countryID: Int
    let localityVerbose: String

    enum CodingKeys: String, CodingKey {
        case address, locality, city
        case cityID = "city_id"
        case latitude, longitude, zipcode
        case countryID = "country_id"
        case localityVerbose = "locality_verbose"
    }
}

// MARK: - R
struct R: Codable {
    let resID: Int
    let isGroceryStore: Bool?
    let hasMenuStatus: HasMenuStatus

    enum CodingKeys: String, CodingKey {
        case resID = "res_id"
        case isGroceryStore = "is_grocery_store"
        case hasMenuStatus = "has_menu_status"
    }
}

// MARK: - HasMenuStatus
struct HasMenuStatus: Codable {
    let delivery: Delivery
    let takeaway: Int
}

enum Delivery: Codable {
    case bool(Bool)
    case integer(Int)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        throw DecodingError.typeMismatch(Delivery.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Delivery"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .integer(let x):
            try container.encode(x)
        }
    }
}

// MARK: - UserRating
struct UserRating: Codable {
    let aggregateRating, ratingText, ratingColor: String
    let ratingObj: RatingObj
    let votes: Int

    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case ratingObj = "rating_obj"
        case votes
    }
}

// MARK: - RatingObj
struct RatingObj: Codable {
    let title: Title
    let bgColor: BgColor

    enum CodingKeys: String, CodingKey {
        case title
        case bgColor = "bg_color"
    }
}

// MARK: - BgColor
struct BgColor: Codable {
    let type, tint: String
}

// MARK: - Title
struct Title: Codable {
    let text: String
}

// MARK: - Popularity
struct Popularity: Codable {
    let popularity, nightlifeIndex: String
    let nearbyRes, topCuisines: [String]
    let popularityRes, nightlifeRes, subzone: String
    let subzoneID: Int
    let city: String

    enum CodingKeys: String, CodingKey {
        case popularity
        case nightlifeIndex = "nightlife_index"
        case nearbyRes = "nearby_res"
        case topCuisines = "top_cuisines"
        case popularityRes = "popularity_res"
        case nightlifeRes = "nightlife_res"
        case subzone
        case subzoneID = "subzone_id"
        case city
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


