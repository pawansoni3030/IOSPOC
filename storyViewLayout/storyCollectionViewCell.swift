//
//  storyCollectionViewCell.swift
//  storyViewLayout
//
//  Created by Pawan on 10/07/23.
//

import UIKit

class storyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myView: UIView!
    private var userImageString: String!

    func setUpStoryView(userImageString: String,viewController : UIViewController){
        var isVideo : Bool!
        self.userImageString = userImageString
        // check url is a video or image default--> image
        let imageView = UIImageView()
        ImageUtil().downloadImage(from: URL(string: self.userImageString)!, imageView: imageView, isCircle: false)
        isVideo = ImageUtil().checkIfVideo(storyLink: userImageString)
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        imageView.contentMode = .scaleAspectFit
        self.myView.addSubview(imageView)
        if isVideo == true{
            StoryVideo.shared.play(view: imageView, url: URL(string: userImageString)!, vc: viewController)
            StoryVideo().restart()
        }
    }

}
