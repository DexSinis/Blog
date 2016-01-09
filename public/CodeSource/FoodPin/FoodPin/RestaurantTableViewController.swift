//
//  NSUITableViewController.swift
//  NSTableViewController
//
//  Created by 000 on 15/9/10.
//  Copyright (c) 2015年 000. All rights reserved.
//

import UIKit
class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["Cafe Deadend sadsadasdfjsdfdjsnfjdsnfsdfdjfkdjfkdjfdsjfdsfjdsfdnfdsnfdsnfksdfndsjnfjdsnfjsdnfjdsfjsdfsdfsdjfkdsjfksdjfksdjfksdfsdjfsdjfjsdjfksdjfksdjfksdjfsdjfksjfksdjfkdsjfnviffdsfsdfjeufsdfdfjksdfjsdfjdjncdfsdfhdsfiwefdsfdksfkdsfjsdkjfdfjkdfjdsfd", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier:"myIdens")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CustomTableViewCell {
        var restaurant = Restaurant()
        restaurant.name = restaurantNames[indexPath.row]
        restaurant.image = UIImage(named: restaurantImages[indexPath.row])
        restaurant.location = restaurantLocations[indexPath.row]
        restaurant.type = restaurantTypes[indexPath.row]
        
        
        let idens = "myIdens"
        var cell = tableView.dequeueReusableCellWithIdentifier(idens)as? CustomTableViewCell
        if(cell == nil)
        {
            cell = CustomTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:idens)
            cell?.backgroundColor = UIColor.orangeColor()
        }
        cell!.restaurant = restaurant
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
            
        var height = tableView.fd_heightForCellWithIdentifier("myIdens", cacheByIndexPath: indexPath, configuration: {
             (make) -> Void in
            var cellT:CustomTableViewCell = make as! CustomTableViewCell
            var restaurant = Restaurant()
            restaurant.name = self.restaurantNames[indexPath.row]
            restaurant.image = UIImage(named: self.restaurantImages[indexPath.row])
            restaurant.location = self.restaurantLocations[indexPath.row]
            restaurant.type = self.restaurantTypes[indexPath.row]
            cellT.restaurant = restaurant
            cellT.updateHeightCell()
        })
        
        return height;

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
