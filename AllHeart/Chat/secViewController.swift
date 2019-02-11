//
//  secViewController.swift
//  Ability
//
//  Created by BlueGrey on 2017/12/23.
//  Copyright © 2017年 blueGrey. All rights reserved.
//

import UIKit
import AVOSCloud
import LeanCloud
class secViewController: RCConversationListViewController,RCIMUserInfoDataSource {
    
    
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        let  query=AVQuery(className: "myuser")
        query.whereKey("username", matchesRegex: userId)
        let temp=query.findObjects() as! [AVObject]
        var url=""
        if(temp.count>0)
        {
            let U=temp[0]["image"] as! AVFile
            url=U.url!
            //  let U=temp!["image"] as! AVFile
            //  photoImageView.image=UIImage(data: U.getData()!)
            // text.text=temp?["string"] as! String
        }
        print(url)
        return completion(RCUserInfo(userId: userId, name: userId, portrait: url))
    }
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        RCIM.shared().userInfoDataSource=self
        
        
        // Do any additional setup after loading the view.
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue, RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_CHATROOM.rawValue, RCConversationType.ConversationType_GROUP.rawValue, RCConversationType.ConversationType_APPSERVICE.rawValue, RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_GROUP.rawValue])
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    
 
//    override func viewWillDisappear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden=false
//    }
    
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        //打开会话界面
        let chat = RCConversationViewController(conversationType: model.conversationType, targetId: model.targetId)
        chat?.title = model.conversationTitle
        print("jytjytjyt*****")
        self.tabBarController?.tabBar.isHidden=true
        self.navigationController?.pushViewController(chat!, animated: true)
        //
         //self.tabBarController?.tabBar.isHidden=true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
