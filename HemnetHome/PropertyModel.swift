//
//  PropertyModel.swift
//  HemnetHome
//
//  Created by Jonas Lind on 2024-05-06.
//

import Foundation

enum HomeType: Decodable {
    case area(Area)
    case property(Property)
    case highlightedProperty(Property)

    enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "Area":
            let data = try Area(from: decoder)
            self = .area(data)
        case "Property":
            let data = try Property(from: decoder)
            self = .property(data)
        case "HighlightedProperty":
            let data = try Property(from: decoder)
            self = .highlightedProperty(data)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid type")
        }
    }
}

struct Response: Decodable {
    let items: [HomeType]
}

struct Area: Identifiable, Decodable {
    var id: String
    var area: String
    var ratingFormatted: String
    var averagePrice: Int
    var image: String
}

struct Property: Identifiable, Decodable {
    var id: String
    var askingPrice: Int
    var monthlyFee: Int?
    var municipality: String
    var area: String
    var daysSincePublish: Int
    var livingArea: Int
    var numberOfRooms: Int
    var streetAddress: String
    var image: String
}

struct PropertyDetails: Identifiable, Decodable {
    var id: String
    var askingPrice: Int
    var municipality: String
    var area: String
    var daysSincePublish: Int
    var livingArea: Int
    var numberOfRooms: Int
    var streetAddress: String
    var image: String
    var description: String
    var patio: String
}
