//
//  MeViewController.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/6.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit
import LeanCloud

class MeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var username: UILabel!
    var image = UIImage(named: "admin.jpg")?.toCircle()
    var isupdatingHead : Bool = false
    @IBOutlet weak var loginbutton: UIBarButtonItem!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var imgbutton: UIButton!
    @IBOutlet weak var hpt: UIImageView!
    let cql = CQL()
    override func viewWillAppear(_ animated: Bool) {
        //判断用户是否登录
        if let _un = UserDefaults.standard.string(forKey: "name") {
            if _un != ""{
                change(str: _un)
                //获取用户头像
                if !isupdatingHead{
                    cql.getHead(userName: _un, finished: { (img) in
                        DispatchQueue.main.async {
                            self.hpt.image = img
                        }
                        
                    })
                }
                isupdatingHead = false
                
            }else{
                //self.myData.isEnabled = false
                self.imgbutton.isEnabled = false
                self.hpt.image = image?.toCircle()
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.username.text = "请登录"
        // Do any additional setup after loading the view.
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.loginbutton.title = "登录"
        self.loginbutton.isEnabled = true
        
       //self.myData.isEnabled = true
        self.hpt.image = UIImage(named: "admin.jpg")?.toCircle()
        
        self.username.text = "请登录"
        UserDefaults.standard.set("", forKey: "name")
        self.cancelbutton.setTitle("", for: UIControl.State.normal)
        cancelbutton.backgroundColor = UIColor.white
        self.viewWillAppear(true)
    }
    
    
    //用户登录以后界面的改变
    func change(str:String) {
        self.loginbutton.title = ""
        self.loginbutton.isEnabled = false
        self.username.text = str
        self.imgbutton.isEnabled = true
        //self.myData.isEnabled = true
        self.cancelbutton.setTitle("注销", for: UIControl.State.normal)
        cancelbutton.backgroundColor = UIColor.red
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain ultiple representations of the image. ou want to use the original.
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage as! String] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        //hpt.image = selectedImage.toCircle()
        
        self.hpt.image = selectedImage.scaleImage(scaleSize: 0.05).toCircle()
        
        cql.updateHead(userName: username.text!, image: self.hpt.image!)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        self.isupdatingHead = true
        
    }
    @IBAction func selectImageFromPL(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "修改头像", style: .default, handler: { (action: UIAlertAction) in
            let imagePickerController = UIImagePickerController()
            // Only allow photos to be picked, not taken.
            imagePickerController.sourceType = .photoLibrary
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        //self.present(imagePickerController, animated: true, completion: nil)
        actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        
        present(actionSheet, animated: true, completion: nil)
        //-------------------------------------------------------------
    }
    //学姐选择图片
    @IBAction func selectphoto(_ sender:UITapGestureRecognizer){
        print("select picture")
        
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
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
