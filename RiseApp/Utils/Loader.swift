//
//  Loader.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//
import Foundation
import UIKit

class Loader {
    
    enum Status {
        case active, pandingToHide, passive, hiding
    }
    
    let viewSize: CGFloat = 100
    let fadeInDuration: Double = 0.2
    let fadeOutDuration: Double = 0.2
    let minimumDuration: Double = 1.0
    let animationImageCount: Int = 57
    let animationImageName: String =  "img00"
    let backgroundCirclePurpleColor = UIColor(red: 115/255, green: 65/255, blue: 220/255, alpha: 1).cgColor
    let animationView = UIImageView()
    var view = UIView(frame: UIScreen.main.bounds)
    var imgListArray : [UIImage] = []
    var status : Status = .passive
    var viewController : UIViewController?
    private var viewAlpha = CGFloat(0.0)
    private var startTime = Date()
    private static var instance : Loader?
    
    init() {
        populateImageArray()
        animationView.animationImages = imgListArray;
        createLayers(size: viewSize)
        view.alpha = 0
    }
    
    // Class hide function
    class func hide(){
        DispatchQueue.main.async {
            guard let instance = self.instance else {return}
            switch instance.status {
            case .active:
                instance.status = .pandingToHide
                let interval = Date().timeIntervalSince(instance.startTime)
                if  interval < instance.minimumDuration{
                    DispatchQueue.main.asyncAfter(deadline: .now() + instance.minimumDuration - interval , execute: {
                        if instance.status == .pandingToHide{
                            self.hide()
                        }
                    })
                    return
                }else{
                    self.hide()
                }
            case .pandingToHide:
                instance.status = .hiding
                UIView.animate(withDuration: instance.fadeOutDuration, animations: {
                    instance.view.alpha = 0
                }, completion: { (complete) in
                    if complete{
                        if instance.status == .hiding {
                            instance.view.removeFromSuperview()
                            instance.animationView.stopAnimating()
                            instance.status = .passive
                            self.instance = nil
                        }else{
                            instance.view.alpha = 1
                        }
                    }
                })
            default:
                return
            }
        }
    }
    
    // Class show function
    class func show(){
        DispatchQueue.main.async {
            guard let topController = UIApplication.shared.keyWindow?.rootViewController else {return}
            if self.instance == nil{
                self.instance = Loader()
            }
            let instance = self.instance!
            
            instance.startTime = Date()
            switch instance.status {
            case .active:
                break
            case .pandingToHide, .hiding:
                instance.status = .active
            case .passive:
                instance.animationView.startAnimating()
                topController.view?.window?.addSubview(instance.view)
                UIView.animate(withDuration: instance.fadeInDuration) {
                    instance.view.alpha = 1
                }
                instance.status = .active
            }
        }
    }
    
    
    // Instance show function
    func show(on sender: UIViewController) {
        DispatchQueue.main.async {
            self.startTime = Date()
            switch self.status {
            case .active:
                break
            case .pandingToHide, .hiding:
                self.status = .active
            case .passive:
                if (self.viewController == nil){
                    self.viewController = UIViewController()
                    self.viewController?.willMove(toParentViewController: sender)
                    self.viewController?.view.frame = sender.view.frame
                    self.viewController?.view = self.view
                    sender.view.addSubview((self.viewController?.view)!)
                    sender.addChildViewController(self.viewController!)
                    self.viewController?.didMove(toParentViewController: sender)
                    
                    self.animationView.startAnimating()
                    self.view.alpha = 0
                    UIView.animate(withDuration: self.fadeInDuration) {
                        self.view.alpha = 1
                    }
                }
                self.status = .active
            }
        }
    }
    
    // Instance show function
    func hide() {
        DispatchQueue.main.async {
            switch self.status {
            case .active:
                self.status = .pandingToHide
                let interval = Date().timeIntervalSince(self.startTime)
                if  interval < self.minimumDuration{
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.minimumDuration - interval , execute: {
                        if self.status == .pandingToHide{
                            self.hide()
                        }
                    })
                    return
                }else{
                    self.hide()
                }
                
            case .pandingToHide:
                self.status = .hiding
                UIView.animate(withDuration: self.fadeOutDuration, animations: {
                    self.view.alpha = 0
                }, completion: { (complete) in
                    if complete{
                        if self.status == .active {
                            self.view.alpha = 1
                        }else{
                            self.status = .passive
                            self.viewController?.removeFromParentViewController()
                            self.viewController = nil
                        }
                    }
                })
            default:
                return
            }
        }
    }
    
    
    func createLayers(size width: CGFloat){
        
        //Front animation view
        let animationFrameSize = width
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.addSubview(animationView)
        
        let widthConstraint = NSLayoutConstraint(item: animationView, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .width, multiplier: 1.0, constant: width)
        
        let heightConstraint = NSLayoutConstraint(item: animationView, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .height, multiplier: 1.0, constant: width)
        
        let xConstraint = NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([widthConstraint, heightConstraint, xConstraint, yConstraint])
        animationView.contentMode = UIViewContentMode.scaleAspectFill
        self.view.layoutIfNeeded()
        
        //AnimationView background: The Purple circle
        let animationViewPaddingSize = CGFloat(10) //Need to add padding between animationView and backgroundCircle edge
        let backgroundCircleRadius = viewSize/2 + animationViewPaddingSize
        
        let backgroundCircleVerticalOffSet = CGFloat(10) // Animation content is not vertically centered. This magic number behave as offset for vertical centering.
        let backgroundCircleCenter = CGPoint(x: animationView.frame.origin.x + animationFrameSize/2 , y: animationView.frame.origin.y + animationFrameSize/2 + backgroundCircleVerticalOffSet)
        
        // Draw the background circle
        let circlePath = UIBezierPath(arcCenter: backgroundCircleCenter, radius: backgroundCircleRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = backgroundCirclePurpleColor
        shapeLayer.strokeColor = backgroundCirclePurpleColor
        shapeLayer.lineWidth = 1.0
        
        //Add background layer to the animation view
        view.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    //Create a array of images from assets.
    func populateImageArray(){
        for countValue in 1...animationImageCount
        {
            let strImageName : String = "\(animationImageName)\(countValue)"
            guard let image  = UIImage(named:strImageName) else {
                print("Image named \(strImageName) can not found")
                break
            }
            imgListArray.append(image)
        }
    }
    
}

