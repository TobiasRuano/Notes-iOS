//
//  Note.swift
//  Notes
//
//  Created by Tobias Ruano on 20/02/2021.
//

import Foundation

struct Note: Codable {
    var title: String?
    let date: String?
    var body: String?
    let userEmail: String?
}
