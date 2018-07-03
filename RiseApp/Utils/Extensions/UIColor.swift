//
//  UIColor.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 3.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let toslaRed = #colorLiteral(red: 0.9333333333, green: 0.1921568627, blue: 0.1411764706, alpha: 1)           //UIColor(hex: "#EE3124")
    static let toslaPurple = #colorLiteral(red: 0.4509803922, green: 0.2549019608, blue: 0.862745098, alpha: 1)        //UIColor(hex: "#7341dc")
    static let toslaYellow = #colorLiteral(red: 1, green: 0.7450980392, blue: 0, alpha: 1)        //UIColor(hex: "#FFBD00")
    static let toslaTurquoise = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.8235294118, alpha: 1)     //UIColor(hex: "#00D7D2")
    static let toslaDarkgrey = #colorLiteral(red: 0.1764705882, green: 0.1960784314, blue: 0.2156862745, alpha: 1)      //UIColor(hex: "#2D3237")
    static let toslaMidGrey = #colorLiteral(red: 0.6588235294, green: 0.6901960784, blue: 0.7215686275, alpha: 1)       //UIColor(hex: "#A8B0B8")
    static let toslaError = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.2901960784, alpha: 1)         //UIColor(hex: "#FF544A")
    static let toslaConfirm = #colorLiteral(red: 0.09019607843, green: 0.8, blue: 0.5098039216, alpha: 1)       //UIColor(hex: "#17CC82")
    
    //Red tones
    static let toslaDarkRed = #colorLiteral(red: 0.6666666667, green: 0.1176470588, blue: 0.09803921569, alpha: 1)       //UIColor(hex: "#AA1E19")
    static let toslaLightRed = #colorLiteral(red: 1, green: 0.4274509804, blue: 0.3921568627, alpha: 1)      //UIColor(hex: "#FF6D64")
    static let toslaUltraLightRed = #colorLiteral(red: 1, green: 0.9725219607, blue: 0.971904695, alpha: 1) //UIColor(hex: "#FFF6F6")
    
    //Turquoise tones
    static let toslaDarkTurquoise = #colorLiteral(red: 0, green: 0.4901960784, blue: 0.5294117647, alpha: 1)
    
    //PurpleTones
    static let toslaDarkPurple = #colorLiteral(red: 0.3906163871, green: 0.2870368361, blue: 0.6895517111, alpha: 1)
    static let toslaLightPurple = #colorLiteral(red: 0.6389750838, green: 0.5489097834, blue: 0.9508371949, alpha: 1)
    
    static let textColor = #colorLiteral(red: 0.1772714853, green: 0.1983490586, blue: 0.217854321, alpha: 1)
}
