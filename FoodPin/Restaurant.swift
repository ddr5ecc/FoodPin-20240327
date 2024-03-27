//
//  Restaurant.swift
//  FoodPin
//
//  Created by Stephen Lin on 3/1/24.
//

import Foundation

// 建立Restaurant 物件

struct Restaurant {
    var name: String
    var type: String
    var location: String
    var image: String
    var isFavorite: Bool

    // 若有完整參數，將參數宣告為物件
    init(name: String, type: String, location: String, image: String, isFavorite: Bool){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
    }

    // 若無完整參數，指定以下預設參數
    init(){
        self.init(name: "", type: "", location: "", image: "", isFavorite: false)
    }
}
