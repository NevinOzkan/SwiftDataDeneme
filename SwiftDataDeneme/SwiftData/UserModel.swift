//
//  UserModel.swift
//  SwiftDataDeneme
//
//  Created by Nevin Özkan on 21.12.2024.
//

import SwiftData

@Model
class User {
    var name: String
    var birthYear: Int

    init(name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
    }
}
