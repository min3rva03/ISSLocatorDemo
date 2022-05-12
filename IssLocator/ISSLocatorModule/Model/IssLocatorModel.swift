//
//  IssLocatorModel.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 10/05/22.
//

import Foundation

public struct IssLocatorModel : Decodable {
    public var timestamp : Int
    public var message : String?
    public var iss_position: IssPosition
}

public struct IssPosition : Decodable {
    public var latitude : String? = nil
    public var longitude : String? = nil
}
