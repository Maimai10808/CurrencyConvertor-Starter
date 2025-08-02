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
    @Published var baseCurrency: CurrencyChoice = .Usa
    @Published var convertedCurrency: CurrencyChoice = .Euro
    @Published var rates: Rates?
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
    func fetchRates() async {

        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=fc77f240909648d7aff7fe88203ec0d5") else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let rates    = try JSONDecoder().decode(Rates.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
