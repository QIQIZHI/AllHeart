//
//  RegiesterViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/1/14.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit
import LeanCloud
import AVOSCloud
import AVOSCloudIM

class RegiesterViewController: UIViewController {
    let cql = CQL()
    @IBOutlet weak var un: UITextField!
    @IBOutlet weak var pw: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func close(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func resigester(_ sender: UIButton) {
        let _un = un.text
        let _pw = pw.text
        //用户名和密码不能为空
        if un.text?.count != 0 && pw.text?.count != 0{
            //密码位数不能少于5位
            if (un.text?.count)! < 3{
                let alertB = UIAlertController(title: "注册失败", message: "密码不能少于3位！", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                alertB.addAction(okAction)
                self .present(alertB, animated: false, completion: nil)
            }else{
                DispatchQueue.global().async {
                    let randomUser = LCUser()
                    randomUser.username = LCString(_un!)
                    randomUser.password = LCString(_pw!)
                    //用户注册
                    randomUser.signUp(){ result in
                        switch result{
                        case .success:
                            //初始化头像
                            let image = UIImage(named:"admin.jpg")
                            self.cql.initHead(userName: _un!, image: image!)
                            
                            let alertB = UIAlertController(title: "注册成功", message: "点击确定跳转", preferredStyle: UIAlertController.Style.alert)
                            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                                action in
                                self.dismiss(animated: true, completion:nil)
                                
                            })
                            alertB.addAction(okAction)
                            self .present(alertB, animated: false, completion: nil)
                            break
                        case .failure(let error):
                            if error.code == 202{
                                let alertB = UIAlertController(title: "注册失败", message: "用户已经存在", preferredStyle: UIAlertController.Style.alert)
                                let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
                                alertB.addAction(okAction)
                                self .present(alertB, animated: false, completion: nil)
                            }
                        }
                    }
                }
            }
        }else{
            let alertB = UIAlertController(title: "注册失败", message: "用户名和密码均不能为空", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertB.addAction(okAction)
            self .present(alertB, animated: false, completion: nil)
        }
    }

//    @IBAction func selectphoto(_ sender:UITapGestureRecognizer){
//        print("select picture")
//
//        let imagePickerController = UIImagePickerController()
//
//        // Only allow photos to be picked, not taken.
//        imagePickerController.sourceType = .photoLibrary
//
//        // Make sure ViewController is notified when the user picks an image.
//        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        present(imagePickerController, animated: true, completion: nil)
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // Dismiss the picker if the user canceled.
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        // The info dictionary may contain multiple representations of the image. You want to use the original.
//        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage as! String] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
//        }
//
//        // Set photoImageView to display the selected image.
//
//        photo.image = selectedImage.toCircle()
//
//        // Dismiss the picker.
//        dismiss(animated: true, completion: nil)
//    }
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
