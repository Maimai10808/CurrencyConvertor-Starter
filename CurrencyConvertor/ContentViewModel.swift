//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by mac on 8/2/25.
//

import Foundation


class ContentViewModel: ObservableObject {
    
    @Published var baseAmount = ""
    @Published var convertedAmount = ""
    
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
}
