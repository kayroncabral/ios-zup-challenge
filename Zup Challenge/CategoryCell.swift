//
//  CategoryCell.swift
//  Zup Challenge
//
//  Created by Kayron Cabral on 29/12/16.
//  Copyright © 2016 Zup. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate {
    func categoryCellUpdated()
}

class CategoryCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemField: UITextField!
    
    let itemIdentifier = "Item"
    let rowHeight: CGFloat = 44
    
    var delegate: CategoryCellDelegate?
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let text = textField.text {
            if !text.isEmpty {
                category.items.append(text)
                tableView.reloadData()
                delegate?.categoryCellUpdated()
                textField.text = ""
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    
    func deleteOnClick(sender: UIButton) {
        let index = sender.tag
        category.items.removeAtIndex(index)
        delegate?.categoryCellUpdated()
        tableView.reloadData()
    }
    
}
