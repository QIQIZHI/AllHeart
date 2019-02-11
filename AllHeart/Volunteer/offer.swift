//
//  offer.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/9.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import Foundation
import UIKit
class offer{
    var username:String
    var time:String
    var content:String
    var userimg:UIImage?
    init(username:String,time:String,content:String,userimg:UIImage){
        self.username = username
        self.time = time
        self.content = content
        self.userimg = userimg
    }
}
