//
//  I3BlocksTypeTableViewController.swift
//  BlocksForAll
//
//  Created by Lauren Milne on 3/12/17.
//  Copyright © 2017 Lauren Milne. All rights reserved.
//

import UIKit

class I3BlocksTypeTableViewController: UITableViewController {
    var blockDict = NSArray()
    var blockTypes = [Block]()
    var indexToAdd = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Toolbox"
        self.accessibilityLabel = "Toolbox Menu"
        self.accessibilityHint = "Double tap from menu to select block category"
        
        blockDict = NSArray(contentsOfFile: Bundle.main.path(forResource: "BlocksMenu", ofType: "plist")!)!
        
        createBlocksArray()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockTypes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        
        let cellIdentifier = "BlockTypeTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        
        let blockType = blockTypes[indexPath.row]
        cell.textLabel?.text = blockType.name
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = blockType.color
        //cell.bounds.height = 200
        if(indexPath.row >= blockDict.count){
            cell.accessibilityLabel = blockType.name
            cell.accessibilityHint = "Double tap to return to workspace"
        }else{
            cell.accessibilityLabel = blockType.name + " category"
            cell.accessibilityHint = "Double tap to explore blocks in this category"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO check this
        if indexPath.row >= blockDict.count{
            self.performSegue(withIdentifier: "cancelSegue", sender: self)
        }else{
            self.performSegue(withIdentifier: "blockTypeSegue", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.bounds.height/CGFloat(blockTypes.count)
        return height
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        if let myDestination = segue.destination as? I3BlockTableViewController{
            myDestination.typeIndex = tableView.indexPathForSelectedRow?.row
            myDestination.indexToAdd = self.indexToAdd
        }
        
        // Get the new view controller using segue.destinationViewController.
        if let myDestination = segue.destination as? PlaceholderViewController{
            if let blockCell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as? BlockTableViewCell{
                myDestination.blockToAdd = blockCell.block
            }
            // myDestination.blockToAdd = tableView.indexPathForSelectedRow?.row
        }
        
    }
    
    //TODO: this is really convoluted, probably a better way of doing this
    private func createBlocksArray(){
        for item in blockDict{
            if let blockType = item as? NSDictionary{
                let name = blockType.object(forKey: "type") as? String
                var color = UIColor.green
                if let colorString = blockType.object(forKey: "color") as? String{
                    color = UIColor.colorFrom(hexString: colorString)
                }
                guard let block = Block(name: name!, color: color, double: false, editable: false) else {
                    fatalError("Unable to instantiate block")
                }
                blockTypes += [block]
            }
        }
        guard let cancelBlock = Block(name: "Cancel", color: UIColor.red, double: false, editable: false) else {
            fatalError("Unable to instantiate block")
        }
        
        blockTypes += [cancelBlock]
    }

    
}
