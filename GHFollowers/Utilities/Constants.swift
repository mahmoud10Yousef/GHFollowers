//
//  Constants.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/21/21.
//

import UIKit

enum SFSymbols {
    
    static let location  = UIImage(systemName: "mappin.and.ellipse")
    static let repos     = UIImage(systemName: "folder")
    static let gists     = UIImage(systemName: "text.alignleft")
    static let follower  = UIImage(systemName: "person.2")
    static let following = UIImage(systemName: "heart")

}


enum Images{
    
    static let ghLogo         = UIImage(named: "gh-logo")
    static let placeholder    = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")

}


enum ScreenSize{
    
    static let width     = UIScreen.main.bounds.size.width
    static let height    = UIScreen.main.bounds.size.height
    static let maxLength = max(width, height)
    static let minLength = min(width, height)
    
}


enum DeviceTypes{
    
    static let idiom       = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.scale
    static let scale       = UIScreen.main.scale
    
    static let isiphoneSE            = idiom  == .phone && ScreenSize.maxLength  == 568.0
    static let isiphone8Standard     = idiom  == .phone && ScreenSize.maxLength  == 667.0 && nativeScale == scale
    static let isiphone8Zoomed       = idiom  == .phone && ScreenSize.maxLength  == 667.0 && nativeScale > scale
    static let isiphone8PlusStandard = idiom  == .phone && ScreenSize.maxLength  == 736.0
    static let isiphone8PlusZommed   = idiom  == .phone && ScreenSize.maxLength  == 736.0 && nativeScale < scale
    static let isiphoneX             =  idiom == .phone && ScreenSize.maxLength  == 812.0
    static let isiphoneXsMaxAndXr    =  idiom == .phone && ScreenSize.maxLength  == 896.0
    static let isiPad                =  idiom == .phone && ScreenSize.maxLength  >= 1024.0
  
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiphoneX || isiphoneXsMaxAndXr
    }
    
}
