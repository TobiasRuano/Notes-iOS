//
//  DateExtension.swift
//  Notes
//
//  Created by Tobias Ruano on 06/07/2021.
//

import Foundation

extension Date {
    private func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    
    func getDateFormatted(stringDate: String) -> String {
        guard let date = stringToDate(dateString: stringDate) else {
            return "N/A"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}
