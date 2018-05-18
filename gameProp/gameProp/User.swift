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
Para investir na poupança basta ir em qualquer agência e abrir sua conta.

O rendimento será de 0,5% ao mês mais o TR, se a taxa SELIC estiver maior que 8,5% e, será de 70% da SELIC mais o TR nos casos em que a taxa SELIC estiver menor ou igual a 8,5%.
"""
    
    let lciDesc = """
Invista no setor agropecuário ou imobiliário e ajude a economia.
"""
    let lciAprenda = """
Os bancos são responsáveis por vender as letras de crédito desse tipo de investimento, ou seja, é ele quem faz o intermédio
das transações.
"""
    
    let cdbDesc = """
Com este tipo de investimento você empresta dinheiro aos bancos para que eles possam direcioná-lo a outras pessoas.
"""
    
    let cdbAprenda = """
A maioria dos bancos oferece este tipo de investimento, caso tenha interesse, procure seu gerente.

O rendimento é calculado somando-se a IPCA e a taxa fixada.
"""
    
    let tesouroDesc = """
O que você acha de emprestar seu dinheiro ao governo? Isso pode ser feito investindo no tesouro direto.
"""
    let tesouroAprenda = """
Procure uma corretora de valores e entre nos detalhes desse investimento.

O rendimento é calculado somando-se a IPCA e a taxa fixada.
"""
    
    let acoesDesc = """
Este investimento constitui em comprar pequenas partes do capital social de uma empresa.
"""
    let acoesAprenda = """
O rendimento depende de vários fatores do mercado, variando de acordo com cada empresa.

Se o mundo das ações te interessa, procure uma corretora de valores, ela será a ponte entre você e a bolsa de valores.
"""
    override init(){
        let petromil = Investment("Petromil","bloqpetromil", 2.06, 0.0,true,acoesDesc,acoesAprenda)
        petromil.firstTime = false
        let concha = Investment("Concha","bloqconcha", 2.31, 0.0,true,acoesDesc,acoesAprenda)
        concha.firstTime = false
        let gasobras = Investment("Gasobras","bloqgasobras", 1.99, 0.0,true,acoesDesc,acoesAprenda)
        gasobras.firstTime = false
        let transair = Investment("TransAir","bloqTransAir", 2.13, 0.0,true,acoesDesc,acoesAprenda)
        transair.firstTime = false
        investments = [
            Investment("Poupança","desbloqpoupanca", 0.5, 0.0,false,poupancaDesc,poupancaAprenda),
            Investment("LCI","bloqlci", 0.497, 0.0,false,lciDesc,lciAprenda),
            Investment("CDB","bloqcdbcdi", 0.494, 0.0,false,cdbDesc,cdbAprenda),
            Investment("Tesouro Direto (IPCA)","Tesouro Direto", "bloqtesouro", 0.507, 0.0,false,tesouroDesc,tesouroAprenda),
            Investment("Medcare","bloqmedcare", 1.84, 0.0,true,acoesDesc,acoesAprenda),
            petromil,
            concha,
            gasobras,
            transair
        ]
        investments[0].locked = false
    }
    
    let startText = "texto bem vindo"
    
    let ipcaSelic = """
Existem algumas siglas essenciais nesse contexto de investimentos e finanças, e uma delas é a SELIC, taxa básica de juros da economia.
Quando você deseja fazer um empréstimo é essa a taxa que será utilizada para o cálculo dos juros. Ela é responsável por controlar a inflação, também chamada de IPCA, sendo elevada sempre que a inflação subir, para que o consumo diminua e a inflação volte ao normal.
"""
    let rendaCompare = """
Na renda fixa existe uma previsão de quanto renderá o seu investimento. Já na renda variável não há nenhuma garantia, tudo depende dos fatores do mercado, que são bastante imprevisíveis.
"""
    
    var objectives:[Double] = [5, 10, 20, 50, 100, 500, 1200, 2500, 6000, 15000]
    
    var money = 0.0
    var level = 0
    
    func updateLevel(){
        level += 1
        investments[level].locked = false
        investments[level].image = "des\(investments[level].image)"
    }
    
    let tempoRendimentoVariavel = 1
    let tempoRendimentoFixo = 5
    
    let tempoVoltaErro = 15
    
    let azulEscuro = UIColor(red: 30.0/255.0, green: 80.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    let azulMedio = UIColor(red: 0.0, green: 122.0/255.0, blue: 1, alpha: 1.0)
    let azulClaro = UIColor(red: 65.0/255.0, green: 187.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    
    
}
