//
//  CurrencyData.swift
//  CurrencyApp
//
//  Created by Majkel on 31/01/2023.
//

import Foundation

struct CurrencyData: Codable {
    let table: String
    let no: String
    let effectiveDate: String
    let rates: [Rate]
}

struct Rate: Codable {
    let currency: String
    let code: String
    let mid: Double
}
