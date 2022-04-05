//
//  Country.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import Foundation
import RealmSwift

final class Country: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
