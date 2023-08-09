//
//  basicTableViewCell.swift
//  moviesApp
//
//  Created by Pawan on 03/07/23.
//

import UIKit

class basicTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var movieCollectionView: UICollectionView!
    private var movieCollectionArray: Array<Dictionary<String, Any>>?
    private var CollectionViewHeight: CGFloat?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    func setUpTableViewUiAndData(data: Array<Dictionary<String, Any>>?,style: Bool){
        movieCollectionArray = data
        if style == true{
        }else{
        
        }
    }
    func setUpHeightOfCollectionView() -> CGFloat{
       let height =  self.movieCollectionView.collectionViewLayout.collectionViewContentSize.height
        return height
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCollectionArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 4 , height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieDict = getData().getMovieData(MovieDict: (movieCollectionArray?[indexPath.row])!)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "basicCollectionView", for: indexPath) as! basicCollectionViewCell
        cell.movieLabel.text = movieDict.title
        getData().downloadImage(from: URL(string: movieDict.imageUrlString!)!, imageView: cell.ImageView, isCircle: false)
        cell.ImageView.bounds.size.width = UIScreen.main.bounds.width / 4
        cell.FlagLabel.text = movieDict.flagIcon
        cell.contentView.layer.cornerRadius = 20
        return cell
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
