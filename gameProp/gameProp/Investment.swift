//
//  Investment.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 07/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit

class Investment: NSObject {

    var image: String
    var rendimento: String
    var investido: Double
    var receiptDay: Int
    
    init(_ image:String,_ rendimento:String,_ investido:Double, _ receiptDay:Int) {
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
        self.receiptDay = receiptDay
    }
    
}
