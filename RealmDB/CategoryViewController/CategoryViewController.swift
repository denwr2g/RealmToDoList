//
//  CategoryViewController.swift
//  RealmDB
//
//  Created by deniss.lobacs on 15/04/2022.
//

import UIKit
//import RealmSwift

class CategoryViewController: UIViewController {
    
    private var tableView = UITableView()
    private var viewModel: CategoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTable()
        configNavigationItems()
        viewModel?.load()
    }
    
    
}

//MARK: - CategoryViewController Settings

extension CategoryViewController {
    
    func configTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        
    }
    
    func configure(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
    }
    
    func configNavigationItems() {
        navigationItem.title = "Todoey"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    //MARK: - Add new category
    
    @objc func addButtonPressed() {
        presentSearchAlertController(withTitle: "Add New Category", message: "", style: .alert) { [weak self] item in
        
            guard let self = self else { return }
            
            let newCategory = Category()
            newCategory.name = item
            
            self.viewModel?.save(category: newCategory)
            
            self.tableView.reloadData()
            
        }
    }
    
}

//MARK: - TableView DataSource


extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCategoriesCount() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell,
              let category = viewModel?.getCategories(index: indexPath.row) else { return .init() }
        
     //   cell.categoryName.text = viewModel?.getCategories(index: indexPath.row)?.name ?? "No categories added"
        cell.configCell(category)
        return cell
    }
    
    
}

//MARK: - TableView Delegate


extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = viewModel?.getCategories(index: indexPath.row) else { return }
        viewModel?.shouldGoToToDoListViewController(with: category)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let category = viewModel?.getCategories(index: indexPath.row) else { return }
            viewModel?.delete(category: category)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
    }
    
    
}
