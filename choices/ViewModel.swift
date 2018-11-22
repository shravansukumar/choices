//
//  ViewModel.swift
//  choices
//
//  Created by Shravan Sukumar on 18/11/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import Foundation

class ViewModel {
    
    // MARK: - Constants and Variables
    var variants: MasterVar?
    
    // MARK: - typealias
    typealias didFetchVariants = (() -> Void)
    
    // MARK: - Public Methods
    func fetchVariants(_ completion: @escaping didFetchVariants) {
        VariantsRequester().fetchVariants() { [unowned self] variants, success in
            if success {
                self.variants = variants
            }
            completion()
        }
    }
    
    func numberOfSections() -> Int {
        guard let variants = variants else { return 0 }
        return variants.variants.groups.count
    }
    
    func numberOfRows(for index: Int) -> Int {
        guard let variants = variants else { return 0 }
        return variants.variants.groups[index].variations.count
    }
    
    func getVariation(for section: Int, row: Int) -> Variation? {
        guard let variants = variants else { return nil }
        let correspondingGroup = variants.variants.groups[section]
        return correspondingGroup.variations[row]
    }
    
    func getGroup(with index: Int) -> VariantGroup {
        return variants!.variants.groups[index]
    }
    
    func getGroupAndVariation(for group: Int, index: Int) -> (VariantGroup, Variation) {
        let group = variants?.variants.groups[group]
        return (group!, (group?.variations[index])!)
    }
    
    func getExcludedList(for group: Int, variation index: Int) -> [ExcludeList]? {
        guard let variants = variants else { return nil }
        var excludedItems = [ExcludeList]()
        let correspondingGroup = variants.variants.groups[group]
        let correspondingVariations = correspondingGroup.variations[index]
        let itemToBeChecked = ExcludeList(groupId: correspondingGroup.id, variationId: correspondingVariations.id)
        
        variants.variants.excludeList.forEach { groups in
            if groups.contains(itemToBeChecked) {
                excludedItems += groups.filter { $0 != itemToBeChecked }
            }
        }
        return excludedItems
    }
}
