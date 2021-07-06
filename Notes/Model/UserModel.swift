//
//  UserModel.swift
//  Notes
//
//  Created by Tobias Ruano on 20/02/2021.
//

import Foundation

struct User: Codable {
    var id: Int!
    var name: String!
    var surname: String!
    var mail: String!
}
