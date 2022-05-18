//
//  ToDoListViewModel.swift
//  RealmDB
//
//  Created by deniss.lobacs on 25/04/2022.
//

import Foundation

final class ToDoListViewModel {
    
  //  var selectedCategory:Category?
//    var selectedCategory: Category? {
//        didSet {
//            ToDoManager.shared.loadItems()
//        }
//    }
    
//    init() {
//        se
//    }
    
    func loadItems() {
        ToDoManager.shared.loadItems()
    }
    
    func saveItem(item: Item) {
        ToDoManager.shared.saveItem(item: item)
    }
    
    func getItemsCount() -> Int {
        ToDoManager.shared.getItemsCount()
    }
    
//    func foo() {
//        self.selectedCategory?(ToDoManager.shared.selectedCategory!)
//    }
//    func getSelectedCategory() -> Category? {
//        ToDoManager.shared.selectedCategory
//    }
    
    func getItems(index: Int) -> Item? {
        ToDoManager.shared.getItems(index: index)
    }
    
    func deleteItem(item: Item) {
        ToDoManager.shared.deleteItem(item: item)
    }
    
    func updateItem(item: Item) {
        ToDoManager.shared.updateItem(item: item)
    }
    
    func filterByName(title: String) {
        ToDoManager.shared.filterByTitle(title: title)
    }
    

}
