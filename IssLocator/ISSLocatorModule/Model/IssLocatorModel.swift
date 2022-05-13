//
//  IssLocatorModel.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 10/05/22.
//

import Foundation

public struct IssLocatorModel : Codable {
    public var timestamp : Int
    public var message : String?
    public var iss_position: IssPosition?
    
    public func encode(to encoder: Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeIfPresent(timestamp, forKey: .timestamp)
        try encoder.encodeIfPresent(message, forKey: .message)
        try encoder.encodeIfPresent(iss_position, forKey: .iss_position)
    }
    
    enum CodingKeys: String, CodingKey{
        case timestamp, message, iss_position
    }
}

public struct IssPosition : Codable {
    public var latitude : String? = nil
    public var longitude : String? = nil
    
    public func encode(to encoder: Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeIfPresent(latitude, forKey: .latitude)
        try encoder.encodeIfPresent(longitude, forKey: .longitude)
    }
    
    enum CodingKeys: String, CodingKey{
        case longitude, latitude
    }
}
