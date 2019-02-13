//
//  OfferTableViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/8.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit
import os.log
import LeanCloud
import AVOSCloud
import AVOSCloudIM

class OfferTableViewController: UITableViewController {
    //定义一个数组保存数据
    var offerArr = [offer]()
    let cql = CQL()
    var myimage: UIImage?
    override func viewWillAppear(_ animated: Bool) {
        let query=AVQuery(className:"offerInformation")
        query.whereKey("type",equalTo:"11")
        //"createdAt", .Descending
        let temp=query.findObjects() as! [AVObject]
        if(temp.count>0){
            for i in 0..<temp.count{
                let username = temp[i]["username"]
                print(username)
                let time=temp[i]["time"]
                let content=temp[i]["content"]
                
                //let U = temp[i]["userimg"] as! AVFile
                //myimage = UIImage(data:U.getData()!)
                //                cql.getHead(userName: username as! String, finished: { (img) in
                //                    DispatchQueue.main.async {
                //                        print(img)
                //                        self.myimage = img
                //                        print("&&&&&&&&&&&&&&&")
                //                    }
                //                 })
                loadOffer(username: username as! String, time: time as! String, content: content as! String)
                //loadOffer(username: username as! String, time: time as! String, content: content as! String)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //读取leancloud数据
//        let query=AVQuery(className:"offerInformation")
//        query.whereKey("type",equalTo:"11")
//        //"createdAt", .Descending
//        let temp=query.findObjects() as! [AVObject]
//        if(temp.count>0){
//            for i in 0..<temp.count{
//                let username = temp[i]["username"]
//                print(username)
//                let time=temp[i]["time"]
//                let content=temp[i]["content"]
//
//                //let U = temp[i]["userimg"] as! AVFile
//                //myimage = UIImage(data:U.getData()!)
////                cql.getHead(userName: username as! String, finished: { (img) in
////                    DispatchQueue.main.async {
////                        print(img)
////                        self.myimage = img
////                        print("&&&&&&&&&&&&&&&")
////                    }
////                 })
//                loadOffer(username: username as! String, time: time as! String, content: content as! String)
//                //loadOffer(username: username as! String, time: time as! String, content: content as! String)
//            }
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //添加对象到数组
    private func loadOffer(username:String,time:String,content:String){
        let offer1=offer(username: username, time: time, content: content)
        offerArr.append(offer1)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return offerArr.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "offercell", for: indexPath) as! offerTableViewCell
     
     // Configure the cell...
         let off = offerArr[indexPath.row]
         cell.username.text = off.username
         cell.time.text = off.time
         cell.content.text = off.content
        cql.getHead(userName:off.username as! String, finished: { (img) in
                                DispatchQueue.main.async {
                                    print(img)
                                   cell.userimg.image = img
                                    print("&&&&&&&&&&&&&&&")
                                }
        })
         return cell
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
