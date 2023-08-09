//
//  customTableViewCell.swift
//  moviesApp
//
//  Created by Pawan on 03/07/23.
//

import UIKit

class customTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var myBackgroundView: UIView!
    @IBOutlet weak var dataContainerView: UIView!

    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var bannerTextLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var customCollectionViewDataArray: Array<Dictionary<String, Any>>?
    private var myCollectionViewLayout = MYCollectionViewFlowLayout()
    var centerCell: customCollectionViewCell?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dataContainerView.backgroundColor = .clear
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.collectionViewLayout = self.myCollectionViewLayout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        customCollectionViewDataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDict = getData().getMovieData(MovieDict: (customCollectionViewDataArray?[indexPath.row])!)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath) as! customCollectionViewCell
        // add cell Confic
        
        getData().downloadImage(from: URL(string: movieDict.imageUrlString!)!, imageView: cell.myImageView, isCircle: false)
        cell.imageViewHeight.constant = UIScreen.main.bounds.height / 4.5
        cell.imageViewWidth.constant = UIScreen.main.bounds.width / 3
        cell.contentView.layer.cornerRadius = 20
        return cell
    }
    func setUpTableViewUiAndData(data: Array<Dictionary<String, Any>>){
        customCollectionViewDataArray = data
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        let centerPoint =  CGPoint(x: self.collectionView.frame.size.width / 2 + scrollView.contentOffset.x, y: self.collectionView.frame.size.height / 2 + scrollView.contentOffset.y)
        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint){
            self.centerCell = (self.collectionView.cellForItem(at: indexPath) as! customCollectionViewCell)
            self.centerCell?.zoomCenterCell()
            self.centerCell!.layer.zPosition = 12

        }
        if let cell = self.centerCell{
            centerCell?.alphaView.isHidden = true
            let offsetX = centerPoint.x - cell.center.x
            if offsetX < -15 || offsetX > 15{
                cell.zoomOutCell()
                self.centerCell!.layer.zPosition = 0
                centerCell?.alphaView.isHidden = false
                self.centerCell = nil
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
final class MYCollectionViewFlowLayout: UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 16
        minimumInteritemSpacing = 16
        itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5)
    }
    
}
