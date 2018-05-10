//
//  Investment.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 07/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit

class Investment: NSObject {

    var nome: String
    var image: String
    var rendimento: Double
    var investido: Int
    var receiptDay: Int
    
    init(_ nome:String,_ image:String,_ rendimento:Double,_ investido:Int, _ receiptDay:Int) {
        self.nome = nome
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
        self.receiptDay = receiptDay
    }
    
}
