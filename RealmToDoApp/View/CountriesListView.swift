//
//  CountriesListView.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI
import RealmSwift

struct CountriesListView: View {
    
    @ObservedResults(Country.self) var countries
    @FocusState private var isFocused: Bool?
    
    var body: some View {
        NavigationView {
            VStack {
                if countries.isEmpty {
                    Text("Tap on the \(Image(systemName: "plus.circle.fill")) button above to create a new Country.")
                } else {
                    List {
                        ForEach(countries.sorted(byKeyPath: "name")) { country in
                            CountryRowView(country: country, isFocused: _isFocused)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
                Spacer()
            }
            .animation(.default, value: countries)
            .navigationTitle("Countries")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        $countries.append(Country())
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            isFocused = nil
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
        }
    }
}
