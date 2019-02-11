//
//  CQL.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/1/23.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import Foundation
import LeanCloud
import AVOSCloud
import AVOSCloudIM
import UIKit

extension UIImage {
    //生成圆形图片
    func toCircle() -> UIImage {
        //取最短边长
        let shotest = min(self.size.width, self.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        self.draw(in: CGRect(x: (shotest-self.size.width)/2,
                             y: (shotest-self.size.height)/2,
                             width: self.size.width,
                             height: self.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x : 0, y : 0, width:reSize.width, height:reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width:self.size.width * scaleSize, height:self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}
class CQL{
    init(){}
    //获取登录状态
    func getLoginFlag(userName:String){
        LCCQLClient.execute("select loginFlag from _User where username = '\(userName)'"){ result in
            var obId : String = ""
            switch result{
            case .success:
                var loginflag = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOffer(finished : @escaping (_ datas: [LCObject]) -> Void){
        LCCQLClient.execute("select username from offerInformation'") { result in
            
            switch result {
            case .success:
                finished(result.objects)
            //print(result.objects.lcArray.jsonValue)
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    //查询提供帮助信息的条数
    func getOfferCount(){
        LCCQLClient.execute("select count(*) from offerInformation"){ result in
            switch result{
            case .success:
                var count : Int = result.objects.lcValue.jsonValue as! Int
            case .failure(let error):
                print(error)
            }
        }
    }
//    //从leancloud获取发布的提供帮助信息(此处的cql语句有问题）
//    func getOffer(){
//        LCCQLClient.execute("select content from offerInformation by time by desc") { result in
//            var
//        }
//    }
    //初始化头像
    func initHead(userName:String,image:UIImage){
        let obj = AVObject(className:"Headportrait")
        
        let data = image.toCircle().pngData()
        let file = AVFile(data:data!)
        obj.setObject(file,forKey:"headp")
        
        obj.setObject(userName,forKey:"username")
        obj.saveInBackground()
    }
    //获取头像类的objectId
    func getHpId(userName:String,finished : @escaping (_ id : String) -> Void){
        LCCQLClient.execute("select headp from Headportrait where username = '\(userName)'") { result in
            var obId : String = ""
            switch result {
            case .success:
                //
                let test = result.objects.lcValue.jsonValue as! NSArray
                //print(test)
                for t in test{
                    obId = (t as! NSDictionary)["objectId"] as! String
                }
                finished(obId)
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    //更换头像
    func updateHead(userName:String,image:UIImage){
        var id:String = "s"
        
        let data = image.toCircle().pngData()
        let file = AVFile(data: data!)
        getHpId(userName: userName) { (Id) in
            id = Id
            let obj = AVObject(className: "Headportrait",objectId: "\(id)")
            
            let data = image.toCircle().pngData()
            let file = AVFile(data: data!)
            obj.setObject(file, forKey: "headp")
            
            obj.saveInBackground()
        }
        
        
    }
    //获取头像文件的objcetId
    func getHeadId(userName:String,finished : @escaping (_ id : String) -> Void){
        LCCQLClient.execute("select headp from Headportrait where username = '\(userName)'") { result in
            var obId : String = ""
            switch result {
            case .success:
                //
                let test = result.objects.lcValue.jsonValue as! NSArray
                //print(test)
                for t in test{
                    obId = ((t as! NSDictionary)["headp"] as! NSDictionary)["objectId"] as! String
                }
                finished(obId)
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    //通过objectId获取头像信息
    func getHead(userName:String,finished : @escaping (_ image : UIImage) -> Void){
        var id:String = "s"
        getHeadId(userName: userName) { (Id) in
            id = Id
            //print(id)
            LCCQLClient.execute("select url from _File where objectId = '\(id)'") { result in
                switch result{
                case .success:
                    //print(result.objects.lcValue.jsonValue)
                    var url : String = ""
                    let test = result.objects.lcValue.jsonValue as! NSArray
                    
                    for t in test{
                        url = ((t as! NSDictionary))["url"] as! String
                        let url_img = URL(string:url)!
                        //创建请求对象
                        let request = URLRequest(url: url_img)
                        
                        let session = URLSession.shared
                        let dataTask = session.dataTask(with: request, completionHandler: {
                            (data, response, error) -> Void in
                            if error != nil{
                                print(error.debugDescription)
                            }else{
                                //将图片数据赋予UIImage
                                let img = UIImage(data:data!)
                                
                                
                                DispatchQueue.main.async {
                                    finished(img!)
                                }
                                
                            }
                        }) as URLSessionTask
                        
                        //使用resume方法启动任务
                        dataTask.resume()
                        //
                    }
                //print(url)
                case .failure(let error):
                    print(error)
                    
                }
                
            }
        }
    }
        
}
