//
//  CanvasView.swift
//  
//
//  Created by Pawan on 01/02/23.
//

import UIKit

class CanvasView: UIView {
    import UIKit
    import QuartzCore

    struct TouchPointsAndColor {
        var Color: UIColor?
        var Width: CGFloat?
        var Opacity: CGFloat?
        var Point: CGPoint?
    }

    class CanvasView: UIView {
        var line = [TouchPointsAndColor]()
        var stockwidth: CGFloat = 1.0
         
    }

}
