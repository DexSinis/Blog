//
//  RestaurantController.swift
//  FoodPin
//
//  Created by 000 on 15/9/11.
//  Copyright (c) 2015年 000. All rights reserved.
//

import UIKit

class RestaurantController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var dataArray: NSMutableArray?
    var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        self.navigationItem.title = "您好 Swift"
        
        self.dataArray = NSMutableArray()
        self.dataArray!.addObject("11111")
        self.dataArray!.addObject("22222")
        self.dataArray!.addObject("33333")
        self.dataArray!.addObject("44444")
        
        NSLog("%@", self.dataArray!)
        
        self.tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyTestCell")
        self.view.addSubview(self.tableView!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = "Row #  \(self.dataArray!.objectAtIndex(indexPath.row))"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
}
