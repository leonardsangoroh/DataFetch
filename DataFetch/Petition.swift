//
//  Petition.swift
//  DataFetch
//
//  Created by Lee Sangoroh on 18/11/2023.
//

import Foundation

///Petition conforms to Codable Protocol
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
