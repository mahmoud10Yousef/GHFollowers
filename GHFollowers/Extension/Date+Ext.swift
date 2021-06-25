//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/22/21.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat() -> String{
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
