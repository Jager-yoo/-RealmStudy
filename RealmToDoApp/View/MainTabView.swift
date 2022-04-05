//
//  MainTabView.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CountriesListView()
                .tabItem {
                    Label("Countries", systemImage: "airplane.circle")
                }
            
            ToDoListView()
                .tabItem {
                    Label("ToDos", systemImage: "checklist")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
