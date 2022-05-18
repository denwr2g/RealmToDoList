//
//  CategoryViewModel.swift
//  RealmDB
//
//  Created by deniss.lobacs on 15/04/2022.
//

import Foundation
import RealmSwift

final class CategoryViewModel {
    var onGoToToDoListViewController: ((Category) -> Void)?

    func shouldGoToToDoListViewController(with category: Category) {
        self.onGoToToDoListViewController?(category)
    }
    
    func getCategories(index: Int) -> Category? {
        ToDoManager.shared.getCategories(index: index)
    }
    
    func getCategoriesCount() -> Int {
        ToDoManager.shared.getCategoriesCount()
    }
    
    func delete(category: Category) {
        ToDoManager.shared.deleteCategory(category: category)
    }
    
    func save(category: Category) {
        ToDoManager.shared.saveCategoty(category: category)
    }
    
    func load() {
        ToDoManager.shared.loadCategories()
    }
    
}
