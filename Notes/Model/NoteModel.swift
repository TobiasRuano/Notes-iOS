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
    
    private func stringtoDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        guard let date = dateFormatter.date(from: dateString) else {
            #warning("Fix this")
            fatalError()
        }
        return date
    }
    
    func getDateFormatted() -> String {
        if let date = self.updatedAt {
            let date = stringtoDate(dateString: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy, HH:MM"
            let newDate = dateFormatter.string(from: date)
            return newDate
        } else {
            return "N/A"
        }
    }
}
