//
//  helper.swift
//  moviesApp
//
//  Created by Pawan on 03/07/23.
//

import Foundation
import UIKit
// Movie Model
struct movie{
    let title : String?
    let flagIcon : String?
    let imageUrlString: String?
    
    init(title: String?, flagIcon: String?, imageUrlString: String?) {
        self.title = title
        self.flagIcon = flagIcon
        self.imageUrlString = imageUrlString
    }
}
// class to do and get basic models and function
class getData{
// take Dictionary and return Movie Mode;l
    func getMovieData(MovieDict: Dictionary<String,Any>) -> movie{
        let title = MovieDict["title"] as? String ?? ""
        let flag = MovieDict["flag"] as? String ?? ""
        let imageUrl = MovieDict["poster"] as? String ?? ""
    
        return movie(title: title, flagIcon: flag, imageUrlString: imageUrl)
    }
// load jsonFile and return array of Dictionary
    func loadJson(filename fileName: String) -> [String: AnyObject]?{
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
                return jsonObject
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
    }
// download Image and set image
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
                }else{
                    imageView.contentMode = .scaleAspectFill
                }
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
// UI view extention for curve Edge
    extension UIView {
        func addBottomRoundedEdge(desiredCurve: CGFloat?) {
            let offset: CGFloat = self.frame.width / desiredCurve!
            let bounds: CGRect = self.bounds
            print("bounds.size.height : \(bounds.size)")
            
            let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
            let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
            let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
            let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
            rectPath.append(ovalPath)
            
            // Create the shape layer and set its path
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = rectPath.cgPath
            
            // Set the newly created shape layer as the mask for the view's layer
            self.layer.mask = maskLayer
        }
    }
