//
//  Error.swift
//  gameProp
//
//  Created by Túlio Paula e Silva de Holanda Cavalcanti on 16/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit

class Error: NSObject {
    
    static func variavel(_ investments :[Investment]) -> Bool {
        var totalInvestido = 0.0
        var investidoVariavel = 0.0
        
        for investment in investments {
            if(investment.tipoVariavel){
                investidoVariavel += investment.investido
            }
            totalInvestido += investment.investido
        }
        print("investidoVariavel \(investidoVariavel) - totalInvestido \(totalInvestido)")
        return investidoVariavel/totalInvestido >= 3/4
        
    }
    
    static func petroleo(_ investments :[Investment]) -> Bool {
        var totalInvestido = 0.0
        var totalPetroleo = 0.0
        
        for investment in investments {
            if(investment.tipoVariavel){
                if(investment.nome == "Concha" || investment.nome == "Petromil" || investment.nome == "Gasobras"){
                    totalPetroleo += investment.investido
                }
                totalInvestido += investment.investido
            }
        }
        
        return totalPetroleo/totalInvestido >= 4/5
    }
}
