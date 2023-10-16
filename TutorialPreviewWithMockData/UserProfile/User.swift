//
//  User.swift
//  TutorialPreviewWithMockData
//
//  Created by Sarath Sasikala on 16/10/2023.
//

import Foundation

struct User: Decodable {
    var name: String
    var age: Int
    var email: String?
    var isStudent: Bool?
    var gender: String?
}
