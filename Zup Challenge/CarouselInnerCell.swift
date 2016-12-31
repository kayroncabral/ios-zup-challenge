//
//  CarouselInnerCell.swift
//  Zup Challenge
//
//  Created by Kayron Cabral on 30/12/16.
//  Copyright © 2016 Zup. All rights reserved.
//

import UIKit
import iCarousel

class CarouselInnerCell: UIView, iCarouselDelegate, iCarouselDataSource {

    var carousel: iCarousel!
    var items = [String]() {
        didSet {
            carousel?.reloadData()
            let singleItem = items.count == 1
            carousel?.scrollEnabled = !singleItem
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        carousel = iCarousel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        carousel.center = self.center
        carousel.delegate = self
        carousel.dataSource = self
        carousel.vertical = true
        carousel.type = .Rotary
        
        self.addSubview(carousel)
    }
    
    // MARK: - Carousel Delegate + DataSource
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return items.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        
        var label: UILabel
        var shadow: UIView
        
        //reuse view if available, otherwise create a new view
        if let view = view {
            shadow = view
            //get a reference to the label in the recycled view
            label = shadow.viewWithTag(1) as! UILabel
        } else {
            
            shadow = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            shadow.layer.shadowColor = UIColor.blackColor().CGColor
            shadow.layer.shadowOffset = CGSizeZero
            shadow.layer.shadowOpacity = 0.5
            shadow.layer.shadowRadius = 5
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            view.contentMode = .Center
            view.backgroundColor = UIColor.whiteColor()
            view.clipsToBounds = true
            
            label = UILabel(frame: view.bounds)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = label.font.fontWithSize(50)
            label.tag = 1
            view.addSubview(label)
            
            shadow.addSubview(view)
        }
        
        let item = items[index]
        
        label.text = item
        
        return shadow
        
    }
    
}
