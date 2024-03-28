//
//  CategoryModel.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/28/24.
//

import Foundation

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
}

var sampleCategory : [CategoryModel] = [
    .init(title: "All"),
    .init(title: "Men"),
    .init(title: "Women")
]
