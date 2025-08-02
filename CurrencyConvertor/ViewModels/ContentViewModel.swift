//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//  Created by mac on 8/2/25.
//

import Foundation

// conversionrate / basexchangerate * baseAmount = conversion

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var baseAmount = 1.0
    @Published var convertedAmount = 1.0
    @Published var baseCurrency: CurrencyChoice = .Usa
    @Published var convertedCurrency: CurrencyChoice = .Usa
    @Published var rates: Rates?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var successMessage = ""
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
    func fetchRates() async {

        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=fc77f240909648d7aff7fe88203ec0d5") else {
            errorMessage = "Could not fetch rates"
            return
        }
        let urlRequest = URLRequest(url: url)
        
        isLoading = true
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            rates    = try JSONDecoder().decode(Rates.self, from: data)
            
            successMessage = "Currency Data fetched successfully"
            
        } catch {
            errorMessage = "Could not fetch rates"
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func convert() {
        if let rates = rates,
           let baseExchangeRate = rates.rates[baseCurrency.rawValue],
           let convertedExchangeRate = rates.rates[convertedCurrency.rawValue] {
            
            convertedAmount = (convertedExchangeRate / baseExchangeRate) * baseAmount
            
        }
    }
    
}
