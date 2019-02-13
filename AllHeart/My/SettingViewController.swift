//
//  SettingViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/8.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var BtnZhuxiao: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnZhuxiao.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    //返回事件
    @IBAction func BtnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    //注销登录
    @IBAction func zhuxiao(_ sender: UIButton) {
        UserDefaults.standard.set("", forKey: "name")
        BtnZhuxiao.setTitle("", for: UIControl.State.normal)
        BtnZhuxiao.backgroundColor = UIColor.white
        if let _un = UserDefaults.standard.string(forKey: "name") {
            if _un != ""{
                let alertB = UIAlertController(title: "已注销登陆", message: "点击确定跳转", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    self.dismiss(animated: true, completion:nil)
                })
                alertB.addAction(okAction)
                self .present(alertB, animated: false, completion: nil)
            }else{
                let alertB = UIAlertController(title: "您暂未登陆", message: "点击确定跳转", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                    action in
                    self.dismiss(animated: true, completion:nil)
                })
                alertB.addAction(okAction)
                self .present(alertB, animated: false, completion: nil)
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
