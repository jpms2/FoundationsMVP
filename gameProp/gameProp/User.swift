//
//  User.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 5/11/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit

class User: NSObject {

    var investments = [
        Investment("Poupança","moneyPig", 1.0, 0.0,false),
        Investment("CDI","CDB_CDI", 1.0, 0.0,false),
        Investment("LCI","LCI", -0.22, 0.0,false),
        Investment("LCA","LCA", 0.12, 0.0,false),
        Investment("Tesouro Direto (Selic)","Tesouro Direto", "tesouro", 0.12, 0.0,false),
        Investment("Medcare","medcare", 0.69, 0.0,true),
        Investment("Petromil","petromil", 0.69, 0.0,true),
        Investment("Concha","concha", 0.69, 0.0,true),
        Investment("Gasobras","gasobras", 0.69, 0.0,true),
        Investment("TransAir","transar", 0.69, 0.0,true),
    ]
    
    var objectives = [5, 10, 20, 50, 100, 500, 1200, 2500, 6000, 1500]
    
    var money = 0.0
    var level = 0
    
    var textos = [
        
        [
            "descricao": ["texto da descricao1"],
            "aprenda": ["texto de como investir na vida real 1"]
        ],
        [
            "descricao": ["texto da descricao 2"],
            "aprenda": ["texto de como investir na vida real 2"]
        ]]
    
    override init(){
        investments[0].locked = false
    }
    
    func updateLevel(){
        level += 1
        investments[level].locked = false
    }
}
