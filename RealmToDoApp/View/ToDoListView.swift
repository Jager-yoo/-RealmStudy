//
//  ToDoListView.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI
import RealmSwift

struct ToDoListView: View {
    
    @ObservedResults(ToDo.self) var toDos
    @State private var name = ""
    @State private var searchFilter = ""
    @FocusState private var isFocused: Bool?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New ToDo", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused, equals: true)
                    Spacer()
                    Button {
                        let newToDo = ToDo(name: name)
                        $toDos.append(newToDo)
                        name = ""
                        isFocused = nil // 버튼이 눌리면, focus 를 nil 로 만들어서, 키보드가 내려가도록 함
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(name.isEmpty)
                }
                .padding()
                
                List {
                    // keyPath 하나를 기준으로 정렬해서 ForEach 를 돌리는 법
                    // ForEach(toDos.sorted(byKeyPath: "completed")) { toDo in
                    
                    // ObjectId 클래스로 만든 id 에는 '생성된 순서' 정보가 녹아있음.
                    // keyPath 를 "id" 로 잡고 ascending: false 로 지정하면, 최근에 생성된 것부터 내림차순 됨!
                    // 참고로, ascending 은 디폴트 값이 'true' 임. 디폴트로 오름차순이라는 것!
//                    ForEach(toDos.sorted(byKeyPath: "id", ascending: false)) { toDo in
                    
                    // completed 를 1순위, urgency 를 1순위로 정렬하는 법
                    ForEach(toDos.sorted(by: [
                        SortDescriptor(keyPath: "completed"),
                        SortDescriptor(keyPath: "urgency", ascending: false)
                    ])) { toDo in
                        ToDoListRow(toDo: toDo, isFocused: _isFocused)
                    }
//                    .onDelete(perform: $toDos.remove(atOffsets:))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                // 검색 기능 추가
                .searchable(text: $searchFilter, collection: $toDos, keyPath: \.name) {
                    ForEach(toDos) { toDo in
                        Text(toDo.name)
                            .searchCompletion(toDo.name)
                    }
                }
            }
            .animation(.default, value: toDos)
            .navigationTitle("Realm ToDos")
            .toolbar {
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
