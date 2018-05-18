//
//  Popup.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 14/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit
import Toast_Swift

class Popup: NSObject {
    var style = ToastStyle()
    var errorPopup = false
    override init(){
        
        style.displayShadow = true
        if (errorPopup) {
            style.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }else{
            style.backgroundColor = User().azulMedio
        }
    }
    
    func makeToast(_ viewController:UIViewController, _ text:String, posX:Int, posY:Int,image: UIImage?){
        let pos = CGPoint(x: posX, y: posY)
        ToastManager.shared.style = style
        viewController.view.makeToast(text,duration: 10.0, point: pos, title: "Dica!", image: image, completion: { didTap in
        })
    }
    func makeToast(_ viewController:UIViewController,_ title:String,_ text:String, position :ToastPosition,image: UIImage?){
        ToastManager.shared.style = style
        viewController.view.makeToast(text,duration: 10.0, position: position, title: title, image: image, completion: { didTap in
            
        })
    }
    
}
