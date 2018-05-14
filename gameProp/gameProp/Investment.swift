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
    var nomeAbreviado :String
    var image: String
    var rendimento: Double
    var investido: Double
    var rendido : Double
    var firstTime = true
    var locked = true
    var tipoVariavel :Bool
    
    init(_ nome:String,_ image:String,_ rendimento:Double,_ investido:Double, _ tipoVariavel:Bool) {
        self.nome = nome
        self.nomeAbreviado = nome
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
        self.tipoVariavel = tipoVariavel
        self.rendido = 0
    }
    init(_ nome:String,_ nomeAbreviado:String, _ image:String,_ rendimento:Double,_ investido:Double, _ tipoVariavel:Bool) {
        self.nome = nome
        self.nomeAbreviado = nomeAbreviado
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
        self.tipoVariavel = tipoVariavel
        self.rendido = 0
    }
    override init(){
        nome = ""
        nomeAbreviado = ""
        image = ""
        rendimento = 0
        investido = 0
        self.tipoVariavel = false
        self.rendido = 0
        
    }
    
}
