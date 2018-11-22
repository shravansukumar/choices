//
//  Variants.swift
//  choices
//
//  Created by Shravan Sukumar on 17/11/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import Foundation

struct MasterVar: Decodable {
    let variants: Variant
    
    private enum CodingKeys: String, CodingKey {
        case variants = "variants"
    }
}

struct Variant: Decodable {
    let groups: [VariantGroup]
    let excludeList: [[ExcludeList]]
    
    private enum CodingKeys: String, CodingKey {
        case groups = "variant_groups"
        case excludeList = "exclude_list"
    }
}

struct VariantGroup: Decodable {
    let id: String
    let name: String
    let variations: [Variation]
    
    private enum CodingKeys: String, CodingKey {
        case id = "group_id"
        case name
        case variations
    }
}

struct Variation: Decodable {
    let id: String
    let name: String
    let price: Int
    let defaultPrice: Int
    let inStock: Int
    let isVeg: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, price, inStock, isVeg
        case defaultPrice = "default"
    }
}

struct ExcludeList: Equatable {
    let groupId: String
    let variationId: String
    
    init(groupId: String, variationId: String) {
        self.groupId = groupId
        self.variationId = variationId
    }
}

extension ExcludeList: Decodable {
    private enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case variationId = "variation_id"
    }
}


