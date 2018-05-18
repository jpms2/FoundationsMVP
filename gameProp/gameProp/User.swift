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
Saber o que significa essas siglas é o primeiro passo para ser um bom investidor.
SELIC é a taxa básica de juros da economia, quando voce quer pegar um empréstimo é esta taxa que vai ser levada em conta para o calculo dos juros. Ela é responsável por controlar a inflação(IPCA). Sempre que a inflação sobe, o governo eleva a SELIC para que o consumo diminua e a inflação volte ao normal.
"""
    let rendaCompare = """
Na renda fixa se tem previsão de quanto renderá seu investimento. Já na renda variável não há nenhuma garantia, tudo depende dos fatores do mercado, que são bastante imprevisíveis.
"""
    
    var objectives:[Double] = [5, 10, 20, 50, 100, 500, 1200, 2500, 6000, 1500]
    
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
