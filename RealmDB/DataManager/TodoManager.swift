//
//  ItemsManager.swift
//  RealmDB
//
//  Created by deniss.lobacs on 22/04/2022.
//

import Foundation
import RealmSwift

class ToDoManager {
    
    static var shared = ToDoManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    var todoItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    
    //MARK: - Categories methods
    
    func getCategories(index: Int) -> Category? {
        guard let categories = categories else { return nil }
        let array = Array(categories)
        return array[index]
    }
    
    func getCategoriesCount() -> Int {
        guard let categories = categories else { return 1 }
        return categories.count
    }
    
    func deleteCategory(category: Category) {
        do {
            try realm.write {
                realm.delete(category)
            }
        } catch {
            print("Error deleting category, \(error)")
        }
        
    }
    
    func saveCategoty(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category, \(error)")
        }
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
    }
    
    //MARK: - Items methods
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    }
    
    func saveItem(item: Item) {
        do {
            try realm.write {
                guard let currentCategory = selectedCategory else {return}
                
                currentCategory.items.append(item)
            }
        } catch {
            print("Error saving new item, \(error)")
        }
    }
    
    func updateItem(item: Item) {
        do {
            try realm.write {
                item.done = !item.done
            }
        } catch {
            print("Error updating item status, \(error)")
        }
    }
    
    func getItemsCount() -> Int {
        guard let items = todoItems else { return 0 }
        return items.count
    }
    
    func getItems(index: Int) -> Item? {
        guard let items = todoItems else { return nil }
        let array = Array(items)
        return array[index]
    }
    
    func deleteItem(item: Item) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Error deleting item, \(error)")
        }
        
    }
    
    func filterByTitle(title: String) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", title)
            .sorted(byKeyPath: "dateCreated", ascending: true)
    }
    
}
