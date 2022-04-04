//
//  ToDo.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI
import RealmSwift

final class ToDo: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var completed: Bool = false
    @Persisted var urgency: Urgency = .neutral
    
    enum Urgency: Int, PersistableEnum {
        
        case trivial
        case neutral
        case urgent
        
        var text: String {
            switch self {
            case .trivial:
                return "Trivial"
            case .neutral:
                return "Neutral"
            case .urgent:
                return "Urgent"
            }
        }
        
        var color: Color {
            switch self {
            case .trivial:
                return .teal
            case .neutral:
                return .secondary
            case .urgent:
                return .red
            }
        }
    }
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    func increment() -> Urgency {
        switch urgency {
        case .trivial:
            return .neutral
        case .neutral:
            return .urgent
        case .urgent:
            return .trivial
        }
    }
}
