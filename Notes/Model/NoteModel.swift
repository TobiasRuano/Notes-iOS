//
//  Note.swift
//  Notes
//
//  Created by Tobias Ruano on 20/02/2021.
//

import Foundation

struct Note: Codable {
    let id: Int?
    var title: String?
    let createdAt: String?
    let updatedAt: String?
    var content: String?
    let userId: Int?
}
