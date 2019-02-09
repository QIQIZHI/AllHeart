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

class RegiesterViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let cql = CQL()
    @IBOutlet weak var un: UITextField!
    @IBOutlet weak var pw: UITextField!
    @IBOutlet weak var userimg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        un.delegate=self
        un.returnKeyType=UIReturnKeyType.done
        pw.delegate=self
        pw.returnKeyType=UIReturnKeyType.done
        
        //userimg.image=UIImage(named:"admin")?.toCircle()
        
        // Do any additional setup after loading the view.
        userimg.isUserInteractionEnabled=true
        let tagGR=UITapGestureRecognizer(target: self, action: #selector(RegiesterViewController.selectphoto(_:)))
        userimg.addGestureRecognizer(tagGR)
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
//                    let person = LCObject(className:"Person")
//                    person.set("username",value:_un!)
//                    person.set("password",value:_pw!)
//
//                    let obj = AVObject(className:"Headportrait")
//
//                    let data = self.userimg.image!.toCircle().pngData()
//                    let file = AVFile(data:data!)
//                    obj.setObject(file,forKey:"headp")
//
//                    obj.setObject(_un!,forKey:"username")
//                    obj.saveInBackground()
//                    person.save{ result in
//                        switch result{
//                        case .success:
//                            break
//                        case .failure(let error):
//                            print(error)
//                        }
//
//                    }
                    let randomUser = LCUser()
                    randomUser.username = LCString(_un!)
                    randomUser.password = LCString(_pw!)
                    //用户注册
                    randomUser.signUp(){ result in
                        switch result{
                        case .success:
                            //初始化头像
                           // let image = UIImage(named:"admin.jpg")
                            //self.cql.initHead(userName: _un!, image: image!)
                            let obj = AVObject(className:"Headportrait")
                            
                            let data = self.userimg.image!.toCircle().pngData()
                            let file = AVFile(data:data!)
                            obj.setObject(file,forKey:"headp")
                            
                            obj.setObject(_un!,forKey:"username")
                            obj.saveInBackground()
                           
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

    
    @IBAction func selectphoto(_ sender:UITapGestureRecognizer){
        print("select picture22222222222222222222")
        
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        
        userimg.image = selectedImage.toCircle()
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
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
