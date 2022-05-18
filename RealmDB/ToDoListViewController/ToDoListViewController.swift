//
//  ViewController.swift
//  RealmDB
//
//  Created by deniss.lobacs on 14/04/2022.
//

import UIKit
import SnapKit

class ToDoListViewController: UIViewController {
    
    private var tableView = UITableView()
    private var searchController = UISearchController(searchResultsController: nil)
    private var viewModel: ToDoListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configSearchController()
        configNavigationItems()
    }
    
}

// MARK: - ToDoListViewController Table Setup

extension ToDoListViewController {
    
    func configTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ToDoListCell", bundle: nil), forCellReuseIdentifier: "toDoListCell")
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func configSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.delegate = self
        
    }
    
    func configure(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
    }
    
    func configNavigationItems() {
        navigationItem.title = "Items"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    //MARK: - Add new item
    
    @objc func addButtonPressed() {
        presentSearchAlertController(withTitle: "", message: "", style: .alert) { [weak self] item in
            guard let self = self else { return }

            let newItem = Item()
            newItem.title = item
            newItem.dateCreated = Date()
            
            self.viewModel?.saveItem(item: newItem)
            
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - TableView DataSource

extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath) as? ToDoListCell else {return .init()}
        
        if let item = viewModel?.getItems(index: indexPath.row) {
            cell.nameLabel.text = item.title
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.nameLabel.text = "No items added"
            
        }
     
        //  cell.configCell(weather)
        return cell
    }
    
}

//MARK: - TableView Delegate

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = viewModel?.getItems(index: indexPath.row) else { return }
        
        viewModel?.updateItem(item: item)
  
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let item = viewModel?.getItems(index: indexPath.row) else { return }
            
            viewModel?.deleteItem(item: item)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
    }
}

//MARK: - SearchBar Methods

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        viewModel?.filterByName(title: searchBar.text!)
        
        tableView.reloadData()
                
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            viewModel?.loadItems()
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
}

extension ToDoListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.loadItems()
        tableView.reloadData()
    }
}

