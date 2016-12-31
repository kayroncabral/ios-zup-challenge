//
//  CarouselViewController.swift
//  Zup Challenge
//
//  Created by Kayron Cabral on 30/12/16.
//  Copyright © 2016 Zup. All rights reserved.
//

import UIKit
import iCarousel

class CarouselViewController: UIViewController, iCarouselDelegate, iCarouselDataSource {

    @IBOutlet weak var carousel: iCarousel!
    
    var categories = [Category]() {
        didSet {
            carousel?.reloadData()
            let singleItem = categories.count == 1
            carousel?.scrollEnabled = !singleItem
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .Rotary
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Carousel Delegate + DataSource
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return categories.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
    
        var cell: CarouselInnerCell
        
        //reuse view if available, otherwise create a new view
        if let view = view as? CarouselInnerCell {
            cell = view
        } else {
            cell = CarouselInnerCell(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
            cell.contentMode = .Center
        }
        
        let category = categories[index]
        
        cell.items = category.items
        
        return cell
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .Spacing) {
            return value * 1.1
        }
        return value
    }
    
}
