//
//  ViewController.swift
//  panGestureTest
//
//  Created by tax_k on 16/10/2018.
//  Copyright © 2018 tax_k. All rights reserved.
//

import UIKit

enum panAxis : Int {
    case upDown
    case leftRight
    case defaults
}

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var axis:Int = 0
    var startingPoint:CGPoint?
    var startingCenter:CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didSwipeOnView))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
        
    }
    
    @objc func didSwipeOnView(gestureRecognizer: UIPanGestureRecognizer) {
       let testPoint: CGPoint = gestureRecognizer.location(in: view)
        print(testPoint)
        switch gestureRecognizer.state {
        case .began:
            axis = panAxis.defaults.rawValue
            startingPoint = testPoint
            startingCenter = gestureRecognizer.view?.center
        case .changed:
            switch axis {
            case panAxis.defaults.rawValue:
                if fabsf(Float(testPoint.x - startingPoint!.x)) > fabsf(Float(testPoint.y - startingPoint!.y)) && fabs(Float(testPoint.x - (startingPoint?.x)!)) > 20 {
                    axis = panAxis.leftRight.rawValue
                }else if fabsf(Float(testPoint.x - startingPoint!.x)) < fabsf(Float(testPoint.y - startingPoint!.y)) && fabs(Float(testPoint.y - (startingPoint?.y)!)) > 20 {
                    axis = panAxis.upDown.rawValue
                }
             case panAxis.leftRight.rawValue:
                print("hr")
            case panAxis.upDown.rawValue:
                print("vr")
            default:
                break
            }
        case .ended:
            axis = panAxis.defaults.rawValue
        default:
            break
        }
    }
}
