//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount")
                .font(.system(size: 15))
            
            TextField("", value    : $viewModel.$baseAmount,
                          formatter: viewModel.numberFormatter)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.clear)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .overlay(alignment: .trailing) {
                    HStack {
                        viewModel.baseCurrency.image()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        
                        Menu {
                            
                            ForEach(CurrencyChoice.allCases) { currencyChoice in
                                Button(action: {
                                    viewModel.baseCurrency = currencyChoice
                                }, label: {
                                    Text(currencyChoice.fetchMenuName())
                                })
                            }
                            
                        } label: {
                            Text(viewModel.baseCurrency.rawValue)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.black)
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.black)
                        }
                        
                        
                    }
                    .padding(.trailing)
                }
            
            HStack {
                
                Spacer()
                
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.vertical)
                
                Spacer()
                
                }
            
            
            
            Text("Converted To")
                .font(.system(size: 15))
            
            TextField("", value    : $viewModel.$convertedAmount,
                          formatter: viewModel.numberFormatter)
                .font(.system(size: 18, weight: .semibold))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.clear)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .overlay(alignment: .trailing) {
                    HStack {
                        viewModel.convertedCurrency.image()
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        
                        Menu {
                            
                            ForEach(CurrencyChoice.allCases) { currencyChoice in
                                Button(action: {
                                    viewModel.convertedCurrency = currencyChoice
                                }, label: {
                                    Text(currencyChoice.fetchMenuName())
                                })
                            }
                            
                        } label: {
                            Text(viewModel.convertedCurrency.rawValue)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.black)
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.black)
                        }
                        
                        
                    }
                    .padding(.trailing)
                }
            
            HStack {
                Spacer()
                
                Text("1.0000 USD = 2.000000 EUR")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 25)
                
                Spacer()
                
            }
            
            
        }
        .padding(.horizontal)
        .task {
            await viewModel.fetchRates()
        }
    }
}

#Preview {
    ContentView()
}
