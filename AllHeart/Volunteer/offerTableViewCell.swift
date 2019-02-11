//
//  offerTableViewCell.swift
//  AllHeart
//
//  Created by zongpingzhang on 2019/2/8.
//  Copyright © 2019年 zongpingzhang. All rights reserved.
//

import UIKit


class offerTableViewCell: UITableViewCell {
    let cql = CQL()
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UITextView!
    
    @IBOutlet weak var userimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cql.getHead(userName: username.text ?? "zhang3", finished: { (img1) in
            DispatchQueue.main.async {
                print(img1)
                self.img.image = img1
                print("&&&&&&&&&&&&&&&")
            }
            
        })
        // Initialization code
    }

//    @IBAction func close(_ sender: UIBarButtonItem) {
//         self.dismiss(animated: true, completion: nil)
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
