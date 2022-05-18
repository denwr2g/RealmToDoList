//
//  AppDelegate.swift
//  RealmDB
//
//  Created by deniss.lobacs on 14/04/2022.
//

import UIKit
import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
      //  print(Realm.Configuration.defaultConfiguration.fileURL)
        

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        setupNavigationController()
        window?.rootViewController = navigationController
        
        return true
    }
    
    func makeCategoryViewController() -> UIViewController {
        let vc = CategoryViewController()
        let viewModel = CategoryViewModel()
        
        viewModel.onGoToToDoListViewController = { [weak self] category in
            guard let self = self else { return }
            self.navigationController?.pushViewController(self.makeToDoListViewController(category: category), animated: true)
        }
        
        vc.configure(viewModel: viewModel)
        
        return vc
    }
    
    func makeToDoListViewController(category: Category) -> UIViewController {
        let vc = ToDoListViewController()
        let viewModel = ToDoListViewModel()
       // viewModel.foo()
       // viewModel.selectedCategory = category
        //viewModel.selectedCategory = category
       
       // viewModel.getSelectedCategory(category: category)
       // a = category
      //  viewModel.getSelectedCategory() = category
        //vc.selectedCategory = category
        ToDoManager.shared.selectedCategory = category
        
        vc.configure(viewModel: viewModel)
        return vc
    }
    
    
    func setupNavigationController() {
        navigationController = UINavigationController(rootViewController: makeCategoryViewController())
        
    }
    

}

