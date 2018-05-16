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
    
    var initRendimento :Double
    
    var descricao = ""
    var aprenda = ""
    
    init(_ nome:String,_ image:String,_ rendimento:Double,_ investido:Double, _ tipoVariavel:Bool,_ descricao:String,_ aprenda:String) {
        self.nome = nome
        self.nomeAbreviado = nome
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
        self.tipoVariavel = tipoVariavel
        self.rendido = 0
        self.descricao = descricao
        self.aprenda = aprenda
        self.initRendimento = rendimento
    }
    
    init(_ nome:String,_ nomeAbreviado:String, _ image:String,_ rendimento:Double,_ investido:Double, _ tipoVariavel:Bool,_ descricao:String,_ aprenda:String) {
        self.nome = nome
        self.nomeAbreviado = nomeAbreviado
        self.image = image
        self.rendimento = rendimento
        self.investido = investido
        self.tipoVariavel = tipoVariavel
        self.rendido = 0
        self.descricao = descricao
        self.aprenda = aprenda
        self.initRendimento = rendimento
    }
    
    override init(){
        self.nome = ""
        self.nomeAbreviado = ""
        self.image = ""
        self.rendimento = 0
        self.investido = 0
        self.tipoVariavel = false
        self.rendido = 0
        self.initRendimento = rendimento
        
    }
    
    @objc public func creditInvestment() {
        if(!self.locked){
            self.rendido += (self.investido + self.rendido)  * (self.rendimento/100)
        }
    }
    
}
