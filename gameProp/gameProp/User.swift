//
//  User.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 5/11/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit

class User: NSObject {
    var investments: [Investment]

    
    let poupancaDesc =
"""
Investimento em renda fixa mais popular devido a sua segurança e praticidade.
"""
    let poupancaAprenda =
"""
Para investir na poupança basta ir a qualquer agencia e abrir sua conta.

Calculo do rendimento-> Se a taxa SELIC estiver maior que 8,5% - 0,5 ao mês + TR
Se a taxa SELIC estiver menor ou igual a 8,5%- 70% da selim + TR
"""
    
    let lciDesc = """
Invista no setor agropecuário ou imobiliário e ajude a economia.
"""
    let lciAprenda = """
Os bancos são responsáveis por vender as letras de credito desse tipo de investimento.
"""
    
    let cdbDesc = """
(CDB-IPCA) Com este tipo de investimento voce empresta dinheiro a bancos para que eles possam emprestar a outras pessoas.
"""
    
    let cdbAprenda = """
A maioria dos bancos oferece este tipo de investimento, caso tenha interesse, procure seu gerente.

Calculo do rendimento-> IPCA + TF (taxa fixada)
"""
    
    let tesouroDesc = """
(Tesouro-IPCA) O que voce acha de emprestar seu dinheiro ao governo? Sim, voce pode fazer isso investindo no tesouro direto.
"""
    let tesouroAprenda = """
Procure uma corretora de valores e entre nos detalhes desse investimento.

Calculo do rendimento-> IPCA + TF (taxa fixada)
"""
    
    let acoesDesc = """
 Este investimento constitui em comprar pequenas partes do capital social de uma empresa.
"""
    let acoesAprenda = """
Calculo do rendimento-> Fatores do mercado, depende de cada empresa.

Se acoes te interessam, procure uma corretora de valores, ela será a ponte entre voce e a bolsa de valores.
"""
    override init(){
        let petromil = Investment("Petromil","petromil", 0.69, 0.0,true,acoesDesc,acoesAprenda,1)
        petromil.firstTime = false
        let concha = Investment("Concha","concha", 0.69, 0.0,true,acoesDesc,acoesAprenda,1)
        concha.firstTime = false
        let gasobras = Investment("Gasobras","gasobras", 0.69, 0.0,true,acoesDesc,acoesAprenda,1)
        gasobras.firstTime = false
        let transair = Investment("TransAir","transar", 0.69, 0.0,true,acoesDesc,acoesAprenda,1)
        transair.firstTime = false
        investments = [
            Investment("Poupança","moneyPig", 1.0, 0.0,false,poupancaDesc,poupancaAprenda,5),
            Investment("LCI","LCI", 0.22, 0.0,false,lciDesc,lciAprenda,5),
            Investment("CDB","CDB_CDI", 1.0, 0.0,false,cdbDesc,cdbAprenda,5),
            Investment("Tesouro Direto (IPCA)","Tesouro Direto", "tesouro", 0.12, 0.0,false,tesouroDesc,tesouroAprenda,5),
            Investment("Medcare","medcare", 0.69, 0.0,true,acoesDesc,acoesAprenda,5),
            petromil,
            concha,
            gasobras,
            transair
        ]
        investments[0].locked = false
    }
    
    let startText = "texto bem vindo"
    
    let ipcaSelic = """
Saber o que significa essas siglas é o primeiro passo para ser um bom investidor.
SELIC é a taxa básica de juros da economia, quando voce quer pegar um empréstimo é esta taxa que vai ser levada em conta para o calculo dos juros. Ela é responsável por controlar a inflação(IPCA). Sempre que a inflação sobe, o governo eleva a SELIC para que o consumo diminua e a inflação volte ao normal.
"""
    let rendaCompare = """
Na renda fixa se tem previsão de quanto renderá seu investimento. Já na renda variável não há nenhuma garantia, tudo depende dos fatores do mercado, que são bastante imprevisíveis.
"""
    
    var objectives:[Double] = [5, 10, 20, 50, 100, 500, 1200, 2500, 6000, 1500]
    
    var money = 1000.0
    var level = 0
    
    func updateLevel(){
        level += 1
        investments[level].locked = false
    }
    
    

    
}
