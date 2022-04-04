//
//  ToDoListView.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI
import RealmSwift

struct ToDoListView: View {
    
    @ObservedResults(ToDo.self) var ToDos
    @State private var name = ""
    @FocusState private var focus: Bool?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New ToDo", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .focused($focus, equals: true)
                    Spacer()
                    Button {
                        let newToDo = ToDo(name: name)
                        $ToDos.append(newToDo)
                        name = ""
                        focus = nil // 버튼이 눌리면, focus 를 nil 로 만들어서, 키보드가 내려가도록 함
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(name.isEmpty)
                }
                .padding()
                
                List {
                    ForEach(ToDos) { toDo in
                        Text(toDo.name)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Realm ToDos")
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
