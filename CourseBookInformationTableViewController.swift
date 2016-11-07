//
//  CourseBookInformationTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by Waez Dewan on 11/3/16.
//  Copyright © 2016 Layomi Dele-Dare. All rights reserved.
//

import UIKit

class CourseBookInformationTableViewController: UITableViewController {

    var dictCourses = [String:String]()
    var arrayCourses = NSMutableArray()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCourses = NSMutableArray()
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCourses = NSMutableArray()
        for i in 0..<arrayCourses.count {
            let course = arrayCourses[i]
            if course.objectForKey("Dept")!.lowercaseString.containsString(searchText.lowercaseString) {
                dictCourses["Dept"] = "\(course.objectForKey("Dept")!)"
                dictCourses["Course"] = "\(course.objectForKey("Course")!)"
                dictCourses["Section"] = "\(course.objectForKey("Section")!)"
                dictCourses["Author"] = "\(course.objectForKey("Author")!)"
                dictCourses["Title"] = "\(course.objectForKey("Title")!)"
                dictCourses["ISBN"] = "\(course.objectForKey("ISBN")!)"
                dictCourses["Edition"] = "\(course.objectForKey("Edition")!)"
                dictCourses["YR"] = "\(course.objectForKey("YR")!)"
                dictCourses["Status"] = "\(course.objectForKey("Status")!)"
                dictCourses["Instructor"] = "\(course.objectForKey("Instructor")!)"
                dictCourses["Campus"] = "\(course.objectForKey("Campus")!)"
                dictCourses["Price"] = "\(course.objectForKey("Price")!)"
                
                filteredCourses.addObject(dictCourses)
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("coursebooks", ofType: "txt")
        let filemgr = NSFileManager.defaultManager()
        
        if filemgr.fileExistsAtPath(path!) {
            do {
                
                let fullText = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
                let readings = fullText.componentsSeparatedByString("\n") as [String]
                
                for i in 1..<readings.count-1 {
                    let bookData = readings[i].componentsSeparatedByString(",")
                    dictCourses["Dept"] = "\(bookData[0])"
                    dictCourses["Course"] = "\(bookData[1])"
                    dictCourses["Section"] = "\(bookData[2])"
                    dictCourses["Author"] = "\(bookData[3])"
                    dictCourses["Title"] = "\(bookData[4])"
                    dictCourses["ISBN"] = "\(bookData[5])"
                    dictCourses["Edition"] = "\(bookData[6])"
                    dictCourses["YR"] = "\(bookData[7])"
                    dictCourses["Status"] = "\(bookData[8])"
                    dictCourses["Instructor"] = "\(bookData[9])"
                    dictCourses["Campus"] = "\(bookData[10])"
                    dictCourses["Price"] = "\(bookData[11])"
                    
                    arrayCourses.addObject(dictCourses)
                }
                
            } catch let error as NSError {
                print("Error: \(error)")
            }
        }
        self.title = "Courses And Book Information"
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCourses.count
        } else {
            return arrayCourses.count
        }
        
        //return arrayCourses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        //let course = arrayCourses[indexPath.row]
        
        if searchController.active && searchController.searchBar.text != "" {
            let course = filteredCourses[indexPath.row]
            
            cell.textLabel?.text = "\(course.objectForKey("Dept")!) \(course.objectForKey("Course")!) \(course.objectForKey("Section")!)"
            cell.detailTextLabel?.text = "'\(course.objectForKey("Title")!)', \(course.objectForKey("Author")!), \(course.objectForKey("Edition")!) Ed."
            return cell
        } else {
            let course = arrayCourses[indexPath.row]
            
            cell.textLabel?.text = "\(course.objectForKey("Dept")!) \(course.objectForKey("Course")!) \(course.objectForKey("Section")!)"
            cell.detailTextLabel?.text = "'\(course.objectForKey("Title")!)', \(course.objectForKey("Author")!), \(course.objectForKey("Edition")!) Ed."
            return cell
        }
        
        //cell.textLabel?.text = "\(course.objectForKey("Dept")!) \(course.objectForKey("Course")!) \(course.objectForKey("Section")!)"
        //cell.detailTextLabel?.text = "'\(course.objectForKey("Title")!)', \(course.objectForKey("Author")!), \(course.objectForKey("Edition")!) Ed."

        //return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if searchController.active && searchController.searchBar.text != "" {
            let course = filteredCourses[indexPath.row]
            
            let createPostingViewController = storyboard?.instantiateViewControllerWithIdentifier("CreatePostingViewController") as! CreatePostingViewController
            
            createPostingViewController.courseDepartment = "\(course.objectForKey("Dept")!)"
            createPostingViewController.courseNumber = "\(course.objectForKey("Course")!)"
            createPostingViewController.bookTitle = "\(course.objectForKey("Section")!)"
            createPostingViewController.bookAuthor = "\(course.objectForKey("Author")!)"
            createPostingViewController.bookTitle = "\(course.objectForKey("Title")!)"
            createPostingViewController.bookISBN = "\(course.objectForKey("ISBN")!)"
            createPostingViewController.bookEdition = "\(course.objectForKey("Edition")!)"
            createPostingViewController.bookPrice = "\(course.objectForKey("Price")!)"
            
            self.navigationController?.pushViewController(createPostingViewController, animated: true)
        } else {
            let course = arrayCourses[indexPath.row]
            
            let createPostingViewController = storyboard?.instantiateViewControllerWithIdentifier("CreatePostingViewController") as! CreatePostingViewController
            
            createPostingViewController.courseDepartment = "\(course.objectForKey("Dept")!)"
            createPostingViewController.courseNumber = "\(course.objectForKey("Course")!)"
            createPostingViewController.bookAuthor = "\(course.objectForKey("Author")!)"
            createPostingViewController.bookTitle = "\(course.objectForKey("Title")!)"
            createPostingViewController.bookISBN = "\(course.objectForKey("ISBN")!)"
            createPostingViewController.bookEdition = "\(course.objectForKey("Edition")!)"
            createPostingViewController.bookPrice = "\(course.objectForKey("Price")!)"
            
            self.navigationController?.pushViewController(createPostingViewController, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CourseBookInformationTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
