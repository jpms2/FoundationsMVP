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
    
    init(_ image:String,_ rendimento:String,_ investido:Double) {
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
    }
    
}
