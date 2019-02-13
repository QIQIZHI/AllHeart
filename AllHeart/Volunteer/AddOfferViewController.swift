//
//  AddOfferViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/8.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import AVOSCloudIM

class AddOfferViewController: UIViewController {
    let cql = CQL()
    
    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var offerContent: UITextView!
    var isupdatingHead : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        cql.getHead(userName: UserDefaults.standard.string(forKey: "name") ?? "zhang3", finished: { (img) in
            DispatchQueue.main.async {
                //self.myimage.image = img
            }
            
        })
        //offerContent.text = "我能提供什么帮助...."
        // Do any additional setup after loading the view.
    }
    //发布帮助信息
    @IBAction func commit(_ sender: UIButton) {
        //首先要判断登录状态
         if let _un = UserDefaults.standard.string(forKey: "name") {
            if _un != ""{
                let offer = AVObject(className:"offerInformation")
                //获取当前登录的用户名
                offer.setObject(_un,forKey:"username")
//                var ima = UIImage(named:"admin.jpg")?.toCircle()
                //获取当前登录用户的头像（不需要再次上传头像）
                //var ima: UIImage?
                if !isupdatingHead{
                    cql.getHead(userName: _un, finished: { (img) in
                        DispatchQueue.main.async {
                            print(img)
                            self.myimage.image = img
                            print("&&&&&&&&&&&&&&&")
                        }
                        
                    })
                    isupdatingHead = false
                }
                //let data = myimage?.pngData()
                let data = self.myimage.image!.toCircle().pngData()
                let file = AVFile(data:data!)
                offer.setObject(file, forKey: "userimg")
//                let data = ima?.pngData()
//                let file = AVFile(data:data!)
//                offer.setObject(file,forKey:"userimg")
                //获取信息发布时间（即当前时间）
                let date = Date()
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let strNowTime = timeFormatter.string(from: date) as String
                offer.setObject(strNowTime,forKey:"time")
                //获取要发布的信息
                let _content = offerContent.text
                offer.setObject(_content,forKey:"content")
                offer.setObject("11", forKey: "type")
                offer.saveInBackground()
                /*************后续需要添加地址等***********/
                
                
//                //保存
                
//                offer.save { result in
//                    switch result{
//                    case .success:
//                        print("fabuchenggong")
//                        break
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
            }else{
                //跳转到登录界面
                
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
