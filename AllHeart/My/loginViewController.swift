//
//  loginViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/1/14.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import AVOSCloudIM
import Alamofire

class loginViewController  : UIViewController{
    @IBOutlet weak var un: UITextField!
    @IBOutlet weak var pw: UITextField!
    var token=""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func close(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Login(_ sender: UIButton) {
        let _un = un.text
        let _pw = pw.text
        if un.text?.count != 0 && pw.text?.count != 0{
            //登录
            LCUser.logIn(username:_un!,password:_pw!){result in
                switch result{
                case .success(let user):
                    UserDefaults.standard.set(_un!, forKey: "name")
                    let alertB = UIAlertController(title: "登录成功", message: "点击确定跳转", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                        action in
                        self.dismiss(animated: true, completion:nil)
                        
                    })
                    alertB.addAction(okAction)
                    self .present(alertB, animated: false, completion: nil)
                    break
                case .failure(let error):
                    if error.code == 210{
                        let alertB = UIAlertController(title: "登录失败", message: "用户和密码不匹配！", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertB.addAction(okAction)
                        self .present(alertB, animated: false, completion: nil)
                    }else if error.code == 211{
                        let alertB = UIAlertController(title: "登录失败", message: "用户不存在！", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertB.addAction(okAction)
                        self .present(alertB, animated: false, completion: nil)
                    }else{
                        let alertB = UIAlertController(title: "登录失败", message: "系统繁忙，请稍后再试！", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alertB.addAction(okAction)
                        self .present(alertB, animated: false, completion: nil)
                    }
                }
            }
        }else{
            let alertB = UIAlertController(title: "登录失败", message: "用户名和密码均不能为空！", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertB.addAction(okAction)
            self .present(alertB, animated: false, completion: nil)
        }
        
    }
    func requestToken1(userID:String) -> Void {
        let dicUser = ["userId":userID,
                       "name":userID,
                       "portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
        ] //请求token的用户信息
        let urlStr = "https://api.cn.ronghub.com/user/getToken.json" //网址接口
        let appKey = "p5tvi9dspehr4"
        let appSecret = "62ZE1vOiiXaZx5"
        let nonce = "\(arc4random())"   //生成随机数
        let timestamp = "\(NSDate().timeIntervalSince1970)"//时间戳
        var sha1Value = appSecret + nonce + timestamp
        sha1Value = sha1Value.sha1()//数据签名,sha1是一个加密的方法
        let headers = [ //照着文档要求写的Http 请求的 4个head
            "App-key":appKey
            ,"Nonce":nonce
            ,"Timestamp":timestamp
            ,"Signature":sha1Value
        ]
        Alamofire.request(urlStr, method: .post, parameters: dicUser , encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            if let dic = response.result.value  as? NSDictionary{
                let code = dic.value(forKey: "code") as! NSNumber
                if code.stringValue == "200" {
                    print(dic.value(forKey: "token"))
                    self.token=dic.value(forKey: "token") as! String
                    
                    print("sadfasf  "+self.token)
                    self.ConnectOne()
                }
            }
        }
    }
    
    func ConnectOne()->Void{
        RCIM.shared().initWithAppKey("p5tvi9dspehr4")
        
        
        RCIM.shared().connect(withToken: token,success: { (userId) -> Void in
            print("登陆成功。当前登录的用户ID：\(userId)")
        }, error: { (status) -> Void in
            print("登陆的错误码为:\(status.rawValue)")
        }, tokenIncorrect: {
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            print("token错误")
        })
        
    }
    //隐藏键盘事件
    @IBAction func backgroundTap(sender:UIControl){
        un.resignFirstResponder()
        pw.resignFirstResponder()
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
