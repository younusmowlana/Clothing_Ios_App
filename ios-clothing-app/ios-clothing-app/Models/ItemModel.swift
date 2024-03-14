//
//  ItemModel.swift
//  ios-clothing-app
//
//

import Foundation

struct ItemModel: Identifiable,Hashable{
    var id: UUID = .init()
    var title: String
    var icon: String
}

var sampleItems :[ItemModel] = [
    .init(title: "All", icon: "")

]
