//
//  MyReservationTableViewController.swift
//  On-The-House
//
//  Created by Kay Hoang on 19/4/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation
import UIKit

class MyReservationTableViewController: UITableViewController{
  
    var offerToken:OfferModel?
    var Reservations :[[String: Any]] = [[:]]
    var memberID = ""
    var noReservation = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if let member_id = UserDefaults.standard.string(forKey: "member_id")
        {
            self.memberID = member_id
            print("This is member ID: \(memberID)")
        }
        self.loadMyReservations()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = f[alse
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        if(self.Reservations.count == 0){
            return 1
        }
        return self.Reservations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventCell", for: indexPath) as! MyReservationTableViewCell
        if(noReservation){
            cell.nameCell.text = "You have no current reservation!"
            cell.lbVenueName.text = ""
            cell.lbVenueLabel.text = ""
        }else{
            cell.lbVenueLabel.text = "Venue:"
            cell.nameCell.text = Reservations[indexPath.row]["event_name"] as? String
            cell.lbVenueName.text = Reservations[indexPath.row]["venue_name"] as? String
        }
        
        /*
        if ((pastrReservations[indexPath.row]["has_rated"] as? Int) == 1){
            cell.lbRating.text = "You has rated this event!"
        }else{
            cell.lbRating.text = "Please rate this event!"
        }
         */
        return cell
    }
    
    func loadMyReservations(){
        let postBodys = "member_id=\(memberID)"
        if let memberURL = URL(string: "http://ma.on-the-house.org/api/v1/member/reservations"){
            let network = NetworkProcessor(url: memberURL)
            network.PostJSONFromURL(postString: postBodys) { (jsonDictionary) in
                if let status = jsonDictionary?["status"] as? String{
                    if status == "success"{
                        self.Reservations = (jsonDictionary?["reservations"] as? [[String: Any]])!
                        if(self.Reservations.count != 0){
                            self.noReservation = false
                        }
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    }else if status == "error"{
                        print("fail to load json")
                    }
                }
            }
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
