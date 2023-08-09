//
//  storyStruct.swift
//  storyViewLayout
//
//  Created by Pawan on 29/06/23.
//

import Foundation
import UIKit

struct story{
    var items : [Dictionary<String,Any>]
    var thumNail : String?
    var storyLabel : String?
    var message: String?
    var bgImage : String?
    init(items: [Dictionary<String,Any>], thumNail: String?, storyLabel: String?,message: String?,bgImage : String?) {
        self.items = items
        self.thumNail = thumNail
        self.storyLabel = storyLabel
        self.message = message
        self.bgImage = bgImage
    }
}
struct storiesItem {
    var image : String?
    var description: String?
    init(image: String?, description: String?) {
        self.image = image
        self.description = description
    }
}
struct storyStyle{
//    "style":{
//        "story_style": "style_1",
//        "max_line_description": 1,
//        "messgae_priority": "message",
//        "is_timer_active": "inactive",
//        "time_interval": 20,
//        "navbar_back_btn": "active",
//        "bgcolor": "#c2c2c2",
//        "color" : "#ffffff",
//        "radius" : 20,
//        "border_width" : 3,
//        "border_color": "#c2c2c2"
//        "pager_bgColor": "#c2c2c2",
//        "pager_active_color" : "#0a0505"
//        "pager_radius": 10,
//        "pager_color": ,
//        "share_button": "active"
//      }
    
//    UIColor(hexString: color_hex) ?? UIColor.white
    var storyStyle : String?
    var maxLineDesc : Int?
    var message_priority : String?
    var is_timer_active : String?
    var time_interval: Int?
    var navigation_Btn: String?
    var bgColor: UIColor?
    var color: UIColor?
    var radius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor : UIColor?
    var pager_bg_color : UIColor?
    var pager_active_color: UIColor?
    var pager_radius: CGFloat?
    var pager_color : UIColor?
    var share_button : String?
    
    init(storyStyle: String?, maxLineDesc: Int?, message_priority: String?, is_timer_active: String?, time_interval: Int?,navigation_Btn: String,bgColor : UIColor,color: UIColor, radius: CGFloat?, borderWidth: CGFloat?, borderColor: UIColor?, pager_bg_color: UIColor?, pager_active_color: UIColor?, pager_radius: CGFloat?, pager_color: UIColor?, share_button: String?) {
        self.storyStyle = storyStyle
        self.maxLineDesc = maxLineDesc
        self.message_priority = message_priority
        self.is_timer_active = is_timer_active
        self.time_interval = time_interval
        self.navigation_Btn = navigation_Btn
        self.bgColor = bgColor
        self.color = color
        self.radius = radius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.pager_bg_color = pager_bg_color
        self.pager_active_color = pager_active_color
        self.pager_radius = pager_radius
        self.pager_color = pager_color
        self.share_button = share_button
    }
}
class getStoryData{
    func getStoryModel(usersDict: Dictionary<String, Any>?) -> story{
        let title = usersDict?["title"] as? String
        let bgImage = usersDict?["bg_image"] as? String ?? ""
        let url = usersDict?["thum"] as? String ?? ""
        let items = usersDict?["items"] as? [Dictionary<String,Any>] ?? []
        let message = usersDict?["message"] as? String ?? ""
        return story(items: items, thumNail: url, storyLabel: title, message: message, bgImage: bgImage)
    }
    func getItemData(items: Dictionary<String,Any>?) -> storiesItem{
        let image = items?["image"] as? String ?? ""
        let description = items?["text"] as? String ?? ""
        return storiesItem(image: image, description: description)
    }
    func getStoryStyle(style: Dictionary<String,Any>?) -> storyStyle{
        // need to change
        let storyType = style?["story_style"] as? String ?? ""
        let maxLineDescription = style?["max_line_description"] as? Int ?? 3
        let message_priority = style?["messgae_priority"] as? String ?? ""
        let timer_active = style?["is_timer_active"] as? String ?? "deactive"
        let timeInterval = style?["time_interval"] as? Int ?? 20
        let navBarBtn = style?["navbar_back_btn"] as? String ?? "active"
        let bgColor = style?["bgcolor"] as? String ?? "#e51010"
        let color = style?["color"] as? String ?? "#000000"
        let bgUIColor = UIColor(hexString: bgColor)!
        let uicolor = UIColor(hexString: color)!
        let radius = style?["radius"] as? CGFloat ?? 20
        let border_width = style?["border_width"] as? CGFloat ?? 3
        let border_color = style?["border_color"] as? String ?? "#e51010"
        let pagerBgColor = style?["pager_bgColor"] as? String ?? "#e51010"
        let pagerActiveColor = style?["pager_active_color"] as? String ?? "#000000"
        let pagerColor = style?["pager_color"] as? String ?? "#ffffff"
        let pagerRadius = style?["pager_radius"] as? CGFloat ?? 10
        let isShareActive = style?["share_button"] as? String ?? "active"
        return storyStyle(storyStyle: storyType, maxLineDesc: maxLineDescription, message_priority: message_priority,is_timer_active: timer_active,time_interval: timeInterval, navigation_Btn: navBarBtn,bgColor: bgUIColor,color: uicolor,radius: radius,borderWidth: border_width, borderColor: UIColor(hexString: border_color)!,pager_bg_color: UIColor(hexString: pagerBgColor),pager_active_color: UIColor(hexString: pagerActiveColor),pager_radius: pagerRadius,pager_color: UIColor(hexString: pagerColor),share_button: isShareActive )
    }
}

class ImageUtil{
    func downloadImage(from url: URL,imageView: UIImageView,isCircle: Bool?){
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
                if isCircle == true{
                    imageView.layoutSubviews()
                    imageView.layer.cornerRadius = imageView.frame.size.height / 2
                    imageView.contentMode = .scaleToFill
                    imageView.clipsToBounds = true
                }
            }
        }
    }
    func downloadImageToShare(from url: URL,isCircle: Bool?) -> UIImage?{
        var image: UIImage?
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                image = UIImage(data: data)
                print("data \(data)")
                }
            }
        return image
        }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func checkIfVideo(storyLink: String) -> Bool{
        let VideoExtensions = ["mp4", "mkv", "mov","wmv"]
                // Iterate & match the URL objects from your checking results
                let url: URL? = NSURL(fileURLWithPath: storyLink) as URL
                let pathExtention = url?.pathExtension
                    if VideoExtensions.contains(pathExtention!){
//                        showImage(storyLink: storyLink)
                        return true
                    }else{
//                    {   showVideo(storyLink: storyLink)
                        return false
                    }
    }
}

// MARK: - UICOLOR EXTENTION

extension UIColor {
    public convenience init?(hexString: String, alpha: CGFloat = 1) {
        
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        cString = cString.replacingOccurrences(of: " ", with: "")
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return nil
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
        
        return
    }
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

// MARK: - UILABEL EXTENTION
extension UILabel {
  func countLines() -> Int {
    guard let myText = self.text as NSString? else {
      return 0
    }
    // Call self.layoutIfNeeded() if your view uses auto layout
    let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
    return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
  }
}


