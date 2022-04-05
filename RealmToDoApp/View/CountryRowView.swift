//
//  CountryRowView.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI
import RealmSwift

struct CountryRowView: View {
    
    @ObservedRealmObject var country: Country
    @FocusState var isFocused: Bool?
    
    var body: some View {
        HStack {
            TextField("New Country", text: $country.name)
                .focused($isFocused, equals: true)
                .textFieldStyle(.roundedBorder)
            Spacer()
            Text("\(country.cities.count) cities")
        }
        .padding()
        .frame(height: 30)
    }
}
