//
//  City.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import Foundation
import RealmSwift

final class City: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var cities: List<City>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
