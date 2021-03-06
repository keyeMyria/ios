//
//  PostDetailViewController.swift
//  athena-ios
//
//  Created by le.he on 2018/4/13.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import UIKit
import SDWebImage

class PostDetailViewController : UIViewController {
    
    var data: FetchGirlsQueryQuery.Data.Girl? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fromUrl: UIButton!
    @IBOutlet weak var fromId: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var imageHeighConstrant: NSLayoutConstraint!
    @IBAction func fromIdClicked(_ sender: Any) {
        self.showToast(message: "not support yet")
    }
    @IBAction func fromUrlClicked(_ sender: Any) {
        
        
        let urlScheme = Utils.getURLScheme(url: (self.data?.fromUrl)!)
        var url = URL(string: urlScheme)
        if !UIApplication.shared.canOpenURL(URL(string: urlScheme)!) {
            url = URL(string: (self.data?.fromUrl)!)
        }
        
        UIApplication.shared.open(url!, completionHandler: nil)
    }
    
    override func awakeFromNib() {
        
//        self.imgView.layer.cornerRadius = 4.0
//        self.imgView.layer.borderWidth = 1.0
//        self.imgView.layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func imageTapped() {
        Utils.presentBigPreview(
            view: self,
            src: self.data!,
            holderImage: self.imgView.image,
            from: self.view
        )
    }
    override func viewDidLoad() {
        // loaded
        
        self.title = data?.text
        self.textLabel.text = data?.text
        self.titleLabel.text = data?.content
        
        let imageSrc = Utils.getRealImageSrc(image: (data?.img)!)
        self.imgView.sd_setImage(with: URL(string: imageSrc), completed: {(image, error, cacheType, imageURL) in
            let rate = (image?.size.width)! / (image?.size.height)!
            let height = (UIScreen.main.bounds.width - 16) / rate
//            if image?.size.height < 1000 {
//                return
//            }
            self.imageHeighConstrant.constant = height
            self.updateViewConstraints()
        })
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(PostDetailViewController.imageTapped))
        self.imgView.isUserInteractionEnabled = true
        self.imgView.addGestureRecognizer(singleTap)
        self.fromId.setTitle(data?.fromId, for: .normal)
        self.fromUrl.setTitle(data?.fromUrl, for: .normal)
        
        let rightBtn = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(self.onRightBtnClicked))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    @objc private func onRightBtnClicked() {
        print("clicked right btn")
        let actionsSheets = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionsSheets.addAction(UIAlertAction(title: "Like", style: .default, handler: { action in
            print("do like action")
            self.showToast(message: "like not support yet")
        }))
        actionsSheets.addAction(UIAlertAction(title: "Collect", style: .default, handler: { action in
            print("do Collect action")
            self.showToast(message: "collect not support yet")
        }))
        actionsSheets.addAction(UIAlertAction(title: "Like", style: .destructive, handler: { action in
            print("do Delete action")
            self.showToast(message: "delete not support yet")
        }))
        actionsSheets.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsSheets, animated: true, completion: nil)
    }
}
