//
//  CategoryCell.swift
//  RealmDB
//
//  Created by deniss.lobacs on 15/04/2022.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    
    func configCell(_ category: Category) {
        self.categoryName.text = category.name
    }
}
