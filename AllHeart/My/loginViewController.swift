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


class loginViewController  : UIViewController{
    @IBOutlet weak var un: UITextField!
    @IBOutlet weak var pw: UITextField!
    
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
