//
//  AddAskViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/8.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit
import LeanCloud

class AddAskViewController: UIViewController {

    @IBOutlet weak var askcontent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //发布需求
    @IBAction func commit(_ sender: UIButton) {
        //首先要判断登录状态
        if let _un = UserDefaults.standard.string(forKey: "name") {
            if _un != ""{
                let ask = LCObject(className:"askInformation")
                //获取当前登录的用户名
                ask.set("username",value:_un)
                //                //获取当前登录用户的头像（不需要再次上传头像）
                //                cql.getHead(userName: _un, finished: { (img) in
                //                    DispatchQueue.main.async {
                //
                //                    }
                //
                //                })
                //获取信息发布时间（即当前时间）
                let date = Date()
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let strNowTime = timeFormatter.string(from: date) as String
                ask.set("time",value:strNowTime)
                //获取要发布的信息
                let _content = askcontent.text
                ask.set("content",value:_content)
                /*************后续需要添加地址等***********/
                
                
                //保存
                ask.save { result in
                    switch result{
                    case .success:
                        print("fabuchenggong")
                        break
                    case .failure(let error):
                        print(error)
                    }
                }
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
