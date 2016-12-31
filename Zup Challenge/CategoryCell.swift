//
//  CategoryCell.swift
//  Zup Challenge
//
//  Created by Kayron Cabral on 29/12/16.
//  Copyright © 2016 Zup. All rights reserved.
//

import UIKit

//protocol CategoryCellDelegate {
//    func categoryCell(category: Category, newItem: String)
//    func categoryCell(category: Category, removedItem index: Int)
//}

class CategoryCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let itemIdentifier = "Item"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemField: UITextField!
    
    var category = Category() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        itemField.delegate = self
        itemField.clearButtonMode = .Always
    }
    
    // MARK: - TableView Delegate + DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(itemIdentifier, forIndexPath: indexPath) as! CategoryInnerCell
        
        let item = category.items[indexPath.row]
        
        cell.title.text = item
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteOnClick(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        category.items.append(textField.text!)
        tableView.reloadData()
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    
    func deleteOnClick(sender: UIButton) {
        let index = sender.tag
        category.items.removeAtIndex(index)
        tableView.reloadData()
    }
    
}
