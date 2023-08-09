//
//  MainViewController.swift
//  StepWell
//
//  Created by Pawan on 17/02/23.
//

import UIKit
import SafariServices

class MainViewController: UIViewController, SideMenuViewControllerDelegate{

    private var sideMenuViewController : SideMenuViewController!
    private var sideMenuRevealWidth: CGFloat = 260
    private var paddingForRotation: CGFloat = 150
    private var isExpended: Bool = false
    
    private var sideMenuTrailingConstant: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)
        //side menu
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenuID") as? SideMenuViewController
        self.sideMenuViewController.defaultHighlightedCell = 0
        self.sideMenuViewController.delegate = self
        view?.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2:1)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        // Side Menu AutoLayout

           self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false

           if self.revealSideMenuOnTop {
               self.sideMenuTrailingConstant = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
               self.sideMenuTrailingConstant.isActive = true
           }
           NSLayoutConstraint.activate([
               self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
               self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
           ])
          // Default Main View Controller
//          showViewController(viewController: UINavigationController.self, storyboardId: "HomeNavID")
        
        
    }

    
    
}
extension MainViewController: SideMenuViewControllerDelegate{
    func selectedCell(_ row: Int) {
        switch row{
        case 0:
            self.showViewController(viewControoler:UINavigationController.self,storyboardId:"HomeNavID")
        default:
            break
        }
    }
}
