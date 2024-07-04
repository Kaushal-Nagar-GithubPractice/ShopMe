//
//  Kaushal_Extension.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 03/07/24.
//

import Foundation
import UIKit

extension UIViewController {
    func getFormattedDate(DateInString: String , FromFormate:String , ToFormate : String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = FromFormate
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = ToFormate
        
        let date: Date? = dateFormatterGet.date(from: DateInString)
        print("Date",dateFormatterPrint.string(from: date ?? Date())) // Feb 01,2018
        return dateFormatterPrint.string(from: date ?? Date());
    }
    
    func ConvertStringToDate(formate : String , DateInString : String) -> Date {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = formate
        
        return dateFormatterGet.date(from: DateInString) ?? Date()
    }
}
