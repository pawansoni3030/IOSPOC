//
//  ViewController.swift
//  storyViewLayout
//
//  Created by Pawan on 29/06/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionVIewHeight: NSLayoutConstraint!
    
    var storyDataArray : Array<Dictionary<String,Any>>?
    var storyStyleDict : Dictionary<String,Any>?
    var storieStyle : storyStyle?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson(filename: "storyData")
            myCollectionView.dataSource = self
            myCollectionView.delegate = self

        if let layout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
        myCollectionVIewHeight.constant = myCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func loadJson(filename fileName: String){
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
                if let mydict = jsonObject{
                    storyDataArray = mydict["stories"] as? Array<Dictionary<String,Any>>
                    storyStyleDict = mydict["style"] as? Dictionary<String,Any>
                    storieStyle = getStoryData().getStoryStyle(style: storyStyleDict)
                }
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyDataArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let title = storyDataArray?[indexPath.row]["title"] as? String
        let url = storyDataArray?[indexPath.row]["thum"] as? String ?? ""
        cell.storyLabel.text = title
        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height / 2
        cell.imageView.contentMode = .scaleToFill
        cell.imageView.clipsToBounds = true
        ImageUtil().downloadImage(from: URL(string: url)!, imageView: cell.imageView, isCircle: false)
        cell.imageView.layer.borderWidth = 3
        cell.imageView.layer.borderColor = UIColor.systemPink.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // perform segway
        let title = storyDataArray?[indexPath.row]["title"] as? String ?? "default_name"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let storiesViewController = storyboard.instantiateViewController(withIdentifier: "StoriesViewController") as? storieViewController else {
            return
        }
        storiesViewController.usersStoryArray = self.storyDataArray
        storiesViewController.selectedUserIndex = indexPath.row
        storiesViewController.fileName = title
        storiesViewController.storieStyleDict = self.storieStyle
        self.navigationController?.pushViewController(storiesViewController, animated: false)
    }
}
