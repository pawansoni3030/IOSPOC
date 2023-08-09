//
//  storieViewController.swift
//  storyViewLayout
//
//  Created by Pawan on 30/06/23.
//

import UIKit
import AVKit
import AVFoundation

class storieViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // Initialize User Section
    @IBOutlet weak var storyUserTime: UILabel!
    @IBOutlet weak var userStoryName: UILabel!
    @IBOutlet weak var userStoryImageView: UIImageView!
    @IBOutlet weak var progressView: UIView!
    
    // myView -> BgView
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var shareFileButton: UIButton!
    
    // Initialize PageControl btw styles
    
    @IBOutlet weak var userDataContainer: UIView!
    @IBOutlet weak var storyPageControl: UIPageControl!
    private var pagerIndex = 0
//    @IBOutlet weak var storyPageView: UIView!
    // scroll view pager
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var StoriesheightConstraint: NSLayoutConstraint!
    
    // Initialize Data and stylesource
    private var userDict: story!
    private var itemsDict: storiesItem!
    private var userSnapArray: [String]?
    private var userThumNil: String?
    var usersStoryArray: [Dictionary<String, Any>]?
    var storieStyleDict : storyStyle!
    var selectedUserIndex: Int?
    
    // Initialize File name configure and storyIndex
    private var fileExt: String?
    private var storyIndex:Int = 0
    private var fileMessageString: String?
    var fileName: String = "default"
    
    // Initialize Private var isImageView : Bool = false
    
    @IBOutlet weak var storiesDescription: UILabel!
    private let imageView = UIImageView()
    private let videoView = UIView()
    private let bgImageView = UIImageView()
    private var descriptionString : String?
    
    // Initialize Auto next timer
    private var timer : Timer?
    private var timeInterval : Float = 20
    
    // Initialize Progress bar
    var progressViewStackView = UIStackView()
    var storyProgressBar = UIProgressView()
    var isTimerEnable : Bool = false
    var storyStyle : String? = "style_1"// "style_1" -> pager // default -> insta
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get and Update currenyt user
        setUpStoryStyle()
        updateUserData()
        if storyStyle == "style_1"{
            print("style_1 :: pager")
            storyPageControl.isHidden = false
            storiesCollectionView.isHidden = false
            storyProgressBar.isHidden = true
            userDataContainer.isHidden = true
            storiesCollectionView.dataSource = self
            storiesCollectionView.delegate = self
            storiesCollectionView.backgroundColor = .clear
            storyPageControl.numberOfPages = userDict.items.count
            if let layout = storiesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.scrollDirection = .horizontal
            }
            StoriesheightConstraint.constant = UIScreen.main.bounds.width
            storyPageControl.currentPage = 0
            storyProgressBar.isHidden = true
            userDataContainer.isHidden = true
//            self.navigationController?.navigationBar.isHidden = false
            
        }else{
            print("style_2 :: instagram")
            storyPageControl.isHidden = true
            storiesCollectionView.isHidden = true
            storyProgressBar.isHidden = false
            userDataContainer.isHidden = false
//            self.navigationController?.navigationBar.isHidden = true
        // Start Timer if timer is enable
            startTimer(isEnable: isTimerEnable)
        // Initialize Swipe Gesture Recognizer
            let swipeGesterRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(_:)))
            let swipeGesterRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(_:)))
            let swipeGesterRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(_:)))
        // Configure Swipe Gesture Recognizer
            swipeGesterRecognizerDown.direction = .down
            swipeGesterRecognizerLeft.direction = .left
            swipeGesterRecognizerRight.direction = .right
            myView.addGestureRecognizer(swipeGesterRecognizerDown)
            myView.addGestureRecognizer(swipeGesterRecognizerLeft)
            myView.addGestureRecognizer(swipeGesterRecognizerRight)
        // update Progress Bar data
            updateProgressBarData()
        }
    }
    //MARK: - STORY STYLE CONFIC
    func setUpStoryStyle(){
        self.view.backgroundColor = storieStyleDict.bgColor
        self.myView.backgroundColor = .clear
        self.imageView.backgroundColor = .clear
        self.videoView.backgroundColor = .clear
        if storieStyleDict.share_button == "active"{
            self.shareFileButton.isHidden = false
        }else
        {
            self.shareFileButton.isHidden = true
        }
        if storieStyleDict.is_timer_active == "active"{
            isTimerEnable = true
            self.timeInterval = Float(storieStyleDict.time_interval  ?? 20)
        }else{
            isTimerEnable = false
        }
        storiesDescription.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        storiesDescription.addGestureRecognizer(guestureRecognizer)
        self.storyStyle = storieStyleDict.storyStyle
        if storieStyleDict.navigation_Btn == "active" && storieStyleDict.storyStyle == "style_1"{
            self.navigationController?.navigationBar.isHidden = false
        }else{
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    @objc func labelClicked(_ sender: Any) {
        setReadMore()
    }
    func setReadMore(){
        if storiesDescription.numberOfLines == Int(storieStyleDict.maxLineDesc ?? 3){
            print("EXPEND")
            storiesDescription.text = descriptionString
            storiesDescription.numberOfLines = 0

        }else{
            storiesDescription.text = descriptionString
            var count: CGFloat = CGFloat(storiesDescription.text?.count ?? 0)
            let str = storiesDescription.text!
            let div = storiesDescription.countLines()
            let multiply: CGFloat = CGFloat(storieStyleDict.maxLineDesc ?? 3)
            let trancateString = "...ReadMore"
            count = CGFloat((count / CGFloat(div)) * multiply) - ((count / CGFloat(div)) / CGFloat(storieStyleDict.maxLineDesc ?? 3))
            if count <= 0 || div > 0{
                // hack for 1 line when count goes 0 or below
                count = 30
            }
            let newStr = String(str.prefix(Int(count)))
            print("collapse")
            if storiesDescription.countLines() > Int(storieStyleDict.maxLineDesc ?? 3){
                if descriptionString != ""{
                    print("count \(count)")
                    print("\(newStr)\(trancateString)")
                    storiesDescription.text = "\(newStr)\(trancateString)"
                }
            }
            storiesDescription.numberOfLines = Int(storieStyleDict.maxLineDesc ?? 3)
        }
    }
    
    //MARK: - Initialize Swipe Gesture Function
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer){
        if storyStyle == "style_1"{
        }else{
            // add condition for style
            print("swiped : \(sender)")
            if sender.direction == .down {
                print("Down Swipe")
                self.navigationController?.popViewController(animated: true)
                endTimer()
                return
            }else if sender.direction == .left {
//                print("Left Swipe")
                selectedUserIndex = (selectedUserIndex ?? 0) + 1
                if self.selectedUserIndex ?? 0 < (usersStoryArray?.count ?? 0){
                    self.storyIndex = 0
                    loadStorieData(index: self.storyIndex)
                    updateUserData()
                    updateProgressBarData()
                    resetTimer()
                    return
                }else{
                    self.selectedUserIndex = (selectedUserIndex ?? 0) - 1
                    self.storyIndex = 0
                    print("Snap out of range")
                    self.navigationController?.popViewController(animated: true)
                    endTimer()
                }
            }else if sender.direction == .right{
                selectedUserIndex = (selectedUserIndex ?? 0) - 1
//                print("Right Swipe")
                if selectedUserIndex ?? 0 < 0{
                    self.selectedUserIndex = (selectedUserIndex ?? 0) + 1
                    self.storyIndex = 0
                    loadStorieData(index: storyIndex)
                    print("Snap out of range")
                    self.navigationController?.popViewController(animated: true)
                    endTimer()
                    return
                }else{
                    self.storyIndex = 0
                    loadStorieData(index: storyIndex)
                    updateUserData()
                    updateProgressBarData()
                    resetTimer()
                }
            }
        }
    }
    
    func updateUserData(){
        // function call when changing Current Story user to Another Story...
        userDict = getStoryData().getStoryModel(usersDict: usersStoryArray?[selectedUserIndex ?? 0])
        itemsDict = getStoryData().getItemData(items: userDict.items[storyIndex])
        // setup user label data and style
//            let itemData = getStoryData().getItemData(items: userDict.items[pagerIndex])
            // indexPath for button function
            self.storiesDescription.numberOfLines = 0
            if itemsDict.description != ""{
                descriptionString = itemsDict.description
            }else if storieStyleDict.message_priority == "message"{
                descriptionString = userDict.message
            }else{
                descriptionString = itemsDict.description
            }
            setReadMore()
            self.storiesDescription.textColor = storieStyleDict.color
        if storyStyle == "style_1"{
            storyPageControl.numberOfPages = userDict.items.count
            storyPageControl.backgroundColor = storieStyleDict.pager_bg_color
            storyPageControl.currentPageIndicatorTintColor = storieStyleDict.pager_active_color
            storyPageControl.pageIndicatorTintColor = storieStyleDict.pager_color
            storyPageControl.layer.cornerRadius = storieStyleDict.pager_radius ?? 10
            storyPageControl.currentPage = self.storyIndex
            if userDict.bgImage != nil{
                if userDict.bgImage != ""{
                    ImageUtil().downloadImage(from: URL(string: userDict.bgImage!)!, imageView: bgImageView, isCircle: false)
                    bgImageView.frame = CGRect(x: 0, y: 0, width: self.myView.frame.width, height: self.myView.frame.height)
                    self.myView.addSubview(bgImageView)
                    self.myView.sendSubviewToBack(bgImageView)
                }else{
                    self.bgImageView.removeFromSuperview()
                    bgImageView.isHidden = true
                }
            }else{
                self.bgImageView.removeFromSuperview()
                bgImageView.isHidden = true
            }
            self.userStoryName.text = userDict.storyLabel
            self.fileMessageString = userDict.message
            self.fileName = userDict.storyLabel!
        }else{
            ImageUtil().downloadImage(from: URL(string: userDict.thumNail!)!, imageView: self.userStoryImageView,isCircle: true)
            self.userStoryName.text = userDict.storyLabel
            self.fileMessageString = userDict.message
            self.fileName = userDict.storyLabel!
            self.storyUserTime.text = "2hr"
            loadStorieData(index: self.storyIndex)
        }
    }

    func loadStorieData(index: Int){
        let itemsDict = getStoryData().getItemData(items: userDict.items[index])
        let urlLink = itemsDict.image
//        self.storiesDescription.text = itemsDict.description
        let urlType =  ImageUtil().checkIfVideo(storyLink: urlLink ?? "")
        let url: URL? = NSURL(fileURLWithPath: urlLink ?? "") as URL
        let pathExtention = url?.pathExtension
            fileExt = pathExtention ?? "jpg"
        print("data \(urlType)")
        if urlType == true{
            showVideo(storyLink: urlLink ?? "")
        }else{
            showImage(storyLink: urlLink ?? "")
        }
        if itemsDict.description != ""{
            descriptionString = itemsDict.description
        }else if storieStyleDict.message_priority == "message"{
            descriptionString = userDict.message
        }else{
            descriptionString = itemsDict.description
        }
        storiesDescription.numberOfLines = 0
        setReadMore()
    }
    
    func showImage(storyLink: String){
        self.videoView.removeFromSuperview()
        self.imageView.removeFromSuperview()
        ImageUtil().downloadImage(from: URL(string: storyLink)!, imageView: imageView, isCircle: false)
        imageView.contentMode = .scaleAspectFit
        storyProgressBar.isHidden = false
        bgImageView.isHidden = true
        userDataContainer.isHidden = false
        imageView.frame = CGRect(x: 0, y: 0, width: self.myView.bounds.width, height: self.myView.bounds.height)
        self.myView.addSubview(imageView)
    }
    
    func showVideo(storyLink: String,cell: UICollectionViewCell? = nil){
        self.videoView.removeFromSuperview()
        self.imageView.removeFromSuperview()
        let videoURL = URL(string: storyLink)
        endTimer()
            self.videoView.frame = CGRect(x: 0, y: 0, width: self.myView.frame.width, height: self.myView.frame.height)
            self.myView.addSubview(videoView)
        StoryVideo.shared.play(view: videoView, url: videoURL!, vc: self)
        StoryVideo().restart()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if storyStyle != "style_1"{
            endTimer()
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if storyStyle == "style_1"{
            // Function for collection View on tuchlike Zoom or sooo can be done if required
            
        }else{
            startTimer(isEnable: isTimerEnable)
//            print("timer Start")
            var locationIsRight: Bool = true
            if touches.count == 1 {
                if (touches.first?.location(in: myView).x)! < myView.frame.size.width / 2{
                    locationIsRight = false
                }
                else{
                    locationIsRight = true
                }
            }
            switch (locationIsRight)  {
              case true:
                 moveRight()
              case false:
                 moveLeft()
            }
        }
    }
    
    func moveRight(){
        storiesDescription.numberOfLines = Int(storieStyleDict.maxLineDesc ?? 3)
//        print("Right")
        self.storyIndex = self.storyIndex + 1
        print("index: \(self.storyIndex)")
        if self.storyIndex < (userDict.items.count){
            loadStorieData(index: self.storyIndex)
            updateProgressBarData()
            return
        }else{
            // move to next user story and make storyIndex 0 before moving
            self.storyIndex = 0
            self.selectedUserIndex = (selectedUserIndex ?? 0) + 1
            if self.selectedUserIndex ?? 0 < (usersStoryArray?.count ?? 0){
                loadStorieData(index: self.storyIndex)
                updateUserData()
                updateProgressBarData()
                return
            }else{
                self.selectedUserIndex = (selectedUserIndex ?? 0) - 1
                print("Snap Out of index")
                self.navigationController?.popViewController(animated: true)
                endTimer()
                return
            }
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        if storyStyle == "style_1"{
            let itemsDict = getStoryData().getItemData(items: userDict.items[pagerIndex])
            let urlLink = itemsDict.image
//            let urlType =  ImageUtil().checkIfVideo(storyLink: urlLink ?? "")
            let url: URL? = NSURL(fileURLWithPath: urlLink ?? "") as URL
            let pathExtention = url?.pathExtension
                fileExt = pathExtention ?? "jpg"
            storyIndex = pagerIndex
        }
        let itemsDict = getStoryData().getItemData(items: userDict.items[storyIndex])
        if let url = URL(string: itemsDict.image ?? "") {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let fileDataFromUrl = data else { return }
                let temporaryFolder = FileManager.default.temporaryDirectory
                let fileName = "\(self.fileName)_\(self.storyIndex).\(self.fileExt!)"
                print("fileName :: \(fileName)")
                let temporaryFileURL = temporaryFolder.appendingPathComponent(fileName)
                print("temporaryFileURL :: \(temporaryFileURL)")
                    do {
                        try fileDataFromUrl.write(to: temporaryFileURL)
                        // DispatchQueue to avoid UI unresponsive download can take time
                           DispatchQueue.main.async {
                               let activityViewController = UIActivityViewController(activityItems: [temporaryFileURL], applicationActivities: nil)
                               activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
                                     self.present(activityViewController, animated: true, completion: nil)
                            }
                        } catch { print("error :: \(error) " ) }
            }.resume()
        }
    }
    
    func moveLeft(){
        print("left")
        storiesDescription.numberOfLines = Int(storieStyleDict.maxLineDesc ?? 3)
        print("storyIndex :: \(storyIndex)")
        self.storyIndex = self.storyIndex - 1
        if self.storyIndex >= 0{
            loadStorieData(index: self.storyIndex)
            updateProgressBarData()
            return
        }else{
            // move to next user story and make storyIndex 0 before moving
            self.storyIndex = 0
            self.selectedUserIndex = (selectedUserIndex ?? 0) - 1
            if self.selectedUserIndex ?? 0 >= 0{
                loadStorieData(index: self.storyIndex)
                updateUserData()
                updateProgressBarData()
                return
            }else{
                self.selectedUserIndex = (selectedUserIndex ?? 0) + 1
                print("Snap out of range")
                self.navigationController?.popViewController(animated: true)
                endTimer()
                return
            }
        }
    }
    
    func updateProgressBarData(){
        progressViewStackView.removeFromSuperview()
        progressViewStackView = UIStackView()
        progressViewStackView.clipsToBounds = true
        self.progressView.addSubview(progressViewStackView)
        for x in 0..<(userDict.items.count){
            storyProgressBar = UIProgressView()
            progressViewStackView.insertArrangedSubview(storyProgressBar, at: x)
            storyProgressBar.progressTintColor = UIColor.gray
            if storyIndex > x{
                storyProgressBar.setProgress(10, animated: false)
            }
            if storyIndex == x{
                if isTimerEnable == true{
                    self.setProgress()
                }
                else{
                    storyProgressBar.progress = 100
                }
            }
        }
        progressViewStackView.axis = .horizontal
        progressViewStackView.spacing = 10
        progressViewStackView.distribution = .fillEqually
        progressViewStackView.alignment = .center
        progressViewStackView.backgroundColor = .clear
        progressViewStackView.frame = CGRect(x: 5, y: 0, width: self.progressView.frame.width - 10 , height: self.progressView.frame.height)
        progressViewStackView.clipsToBounds = true
        self.progressView.addSubview(progressViewStackView)
        self.progressView.clipsToBounds = true
    }
    
    func setProgress(){
        let timeLap : Float = timeInterval
            self.progressViewStackView.arrangedSubviews.forEach{ progressBar in
                if let progressBar = progressBar as? UIProgressView{
                    DispatchQueue.main.asyncAfter(deadline: .now() + (Double(timeLap) / 100)) {
                            progressBar.setProgress(timeLap, animated: true)
                    }
                }
            }
    }
    
//    MARK: - TIMER ACTIVITY
    func startTimer(isEnable: Bool){
        // add check for enable timer: isEnable? True: False
        if isEnable == true{
            timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.timerActivity), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerActivity(){
        updateProgressBarData()
        self.moveRight()
    }
    
    func endTimer(){
        timer?.invalidate()
    }
    
    func resetTimer(){
        timer?.invalidate()
        startTimer(isEnable: isTimerEnable)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDict.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stories", for: indexPath) as! storyCollectionViewCell
        cell.backgroundColor = .blue
        // add function to add data on cell at rendering not later
        let itemData = getStoryData().getItemData(items: userDict.items[indexPath.row])
        cell.setUpStoryView(userImageString: itemData.image ?? "",viewController: self)
        cell.layer.cornerRadius = storieStyleDict.radius!
        cell.layer.borderWidth = storieStyleDict.borderWidth!
        cell.layer.borderColor = storieStyleDict.borderColor!.cgColor
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 150)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellEdge = calculateEdgeInsert()
        return cellEdge
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        let centerPoint = CGPoint(x: self.storiesCollectionView.frame.size.width / 2 + scrollView.contentOffset.x , y: self.storiesCollectionView.frame.size.height / 2 + scrollView.contentOffset.y)
        if let indexPath = self.storiesCollectionView.indexPathForItem(at: centerPoint){
            // pager index update
            storyPageControl.currentPage = indexPath.row
            pagerIndex = indexPath.row
            let itemData = getStoryData().getItemData(items: userDict.items[pagerIndex])
            // indexPath for button function
            self.storiesDescription.numberOfLines = 0
            if itemData.description != ""{
                descriptionString = itemData.description
            }else if storieStyleDict.message_priority == "message"{
                descriptionString = userDict.message
            }else{
                descriptionString = itemData.description
            }
            setReadMore()
            self.storiesDescription.textColor = storieStyleDict.color
            print("pagerIndex : \(pagerIndex)")
            
            storiesDescription.numberOfLines = Int(storieStyleDict.maxLineDesc ?? 3)
        }
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spaceInset = 2 * calculateCellSpace()
        return spaceInset
    }
    
    func calculateCellSpace() -> CGFloat{
        var spaceInset : CGFloat = 0.0
        let cellWidth = UIScreen.main.bounds.width - 100
        spaceInset = (UIScreen.main.bounds.width - (cellWidth)) / CGFloat(2)
        return spaceInset
    }
    
    func calculateEdgeInsert()->UIEdgeInsets{
        // vertical Implemented
        let spaceInset = calculateCellSpace()
        let cellWidth = UIScreen.main.bounds.width - 100
        var leftInset : CGFloat = spaceInset
        var rightInset : CGFloat = 0.0
        leftInset = ( UIScreen.main.bounds.width - cellWidth) / CGFloat(2)
        rightInset = (leftInset + spaceInset) * CGFloat(userDict.items.count)
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
}
