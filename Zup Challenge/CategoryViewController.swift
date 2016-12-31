//
//  CategoryViewController.swift
//  Zup Challenge
//
//  Created by Kayron Cabral on 29/12/16.
//  Copyright © 2016 Zup. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryNumberField: UITextField!
    
    let categoryIdentifier = "Category"
    let carouselSegue = "CarouselSegue"
    
    var categories = [Category(title: "Category", items: ["Item"])] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryNumberField.text = "1"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView Delegate + DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(categoryIdentifier, forIndexPath: indexPath) as! CategoryCell
        
        let category = categories[indexPath.row]
        
        cell.categoryLabel.text = "\(category.title!) \(indexPath.row + 1)"
        cell.category = category
        
        return cell
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let value = Int(textField.text!) {
            if value > categories.count {
                for _ in categories.count..<value {
                    categories.append(Category(title: "Category", items: ["Item"]))
                }
            } else if value < categories.count {
                for _ in value..<categories.count {
                    categories.removeLast()
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func startOnClic(sender: AnyObject) {
        performSegueWithIdentifier(carouselSegue, sender: sender)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == carouselSegue {
            let carouselViewController = segue.destinationViewController as! CarouselViewController
            carouselViewController.categories = categories
        }
    }
    
}

