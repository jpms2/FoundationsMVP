//
//  ViewController.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 07/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupText: UILabel!
    @IBOutlet weak var closePopup: UIButton!
    
    @IBOutlet weak var contaCorrenteLabel: UILabel!
    @IBOutlet weak var clickButton: UIButton!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var investmentsCollection: UICollectionView!
    var investments = [Investment]()
    var money = 0.0
    var clickedPos = 0
    var user = User()
    var errorVar = false
    var errorPetr = false
    
    func initValues(){
        investmentsCollection.delegate = self
        investmentsCollection.dataSource = self
        setupMoneyDesign()
        setupPopupDesign()
        money = user.money
        investments = user.investments
        
        initTimers()
        
        //test()
        moneyLabel.text = "$ \(Int(money))"
    }
    
    func setupMoneyDesign(){
        moneyView.layer.borderWidth = 2.0
        moneyView.layer.borderColor = UIColor(red: 65.0/255.0, green: 187.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
        moneyView.layer.cornerRadius = 20
    }
    
    func setupPopupDesign(){
        popupView.alpha = 0
        closePopup.alpha = 0
        popupView.layer.cornerRadius = 20
        popupView.layer.borderWidth = 2.0
        popupView.layer.borderColor = UIColor(red: 65.0/255.0, green: 187.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
    }
    
    func test(){
        money = 1000
        
        for investment in investments {
            investment.locked = false
        }
        
    }
    
    
    func initTimers(){
        timer(user.tempoRendimentoVariavel,  #selector(timerRendimentoVariavel))
        timer(user.tempoRendimentoFixo,  #selector(timerRendimentoFixo))
        timer(1, #selector(updateRendimento))
    }
    
    @objc func timerRendimentoVariavel(){
        for investment in investments {
            if(investment.tipoVariavel && !investment.locked){
                investment.rendido += (investment.investido + investment.rendido)  * (investment.rendimento/100)
                if(investment.rendido <= 0){
                    investment.investido += investment.rendido
                    investment.rendido = 0
                }
            }
        }
    }
    
    @objc func timerRendimentoFixo(){
        for investment in investments {
            if(!investment.tipoVariavel && !investment.locked){
                investment.rendido += (investment.investido + investment.rendido)  * (investment.rendimento/100)
                if(investment.rendido <= 0){
                    investment.investido += investment.rendido
                    investment.rendido = 0
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValues()
        
        let popup = Popup()
        popup.makeToast(self, "Olá, bem vindo!", user.startText, position: .center, image: nil)
        
    }
    
    func timer( _ interval: Int, _ selector: Selector){
        Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func tryNextLevel() {
        if(investments[user.level].rendido >= user.objectives[user.level]){
            user.updateLevel()
            dalePopup()
        }
    }
    
    func dalePopup() {
        
        if(user.level == 2){
            showPopup(user.ipcaSelic, 366, 374)
        }
        else if (user.level == 4){
            showPopup(user.rendaCompare, 366, 374)
        }
        else{
            let desc = "Agora você desbloqueou um novo investimento!"
            showPopup(desc, 94, 103)
        }
    }
    
    @objc func updateRendimento(){
        for investment in investments {
            if( investment.tipoVariavel && !investment.locked){
                investment.rendimento += (drand48() - 0.47)/2
                investment.rendimento = investment.rendimento <= -60 ? 0.0 : investment.rendimento
                investment.rendimento = investment.rendimento >= 60 ? 1.0 : investment.rendimento
            }
        }
        investmentsCollection.reloadData()
        
        tryNextLevel()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return investments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let invest = investments[indexPath.row]
        let cell:InvestmentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "investmentCell", for: indexPath) as! InvestmentCollectionViewCell
        let image = UIImage(named: invest.image)
        cell.image.image = image
        cell.investimento.text = "$ \(Int(invest.investido) + Int(invest.rendido))"
        cell.rendimento.text = "\(String(format: "%.2f", invest.rendimento))%"
        cell.nome.text = invest.nomeAbreviado
        
        if invest.locked {
            cell.lockImg.isHidden = false
            cell.lockImg.image = invest.tipoVariavel ? UIImage(named: "cadeadoazul") : UIImage(named: "cadeadobranco")
        }
        else {
            cell.lockImg.isHidden = true
        }
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.0)
        
        if(invest.rendimento > 0){
            cell.rendimento.textColor = UIColor.green
        }
        else if (invest.rendimento < 0){
            cell.rendimento.textColor = UIColor.red
        }
        else {
            cell.rendimento.textColor = UIColor.black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedPos = indexPath.row
        if(!investments[clickedPos].locked){
            performSegue(withIdentifier: "mainToInvestments", sender: nil)
            
        }else{

            let desc = """
            Este nível está bloqueado!

            Para passar de nível é necessário investir $ \(user.objectives[user.level]) em \(investments[user.level].nomeAbreviado)
            Atualmente você possui
            $ \(investments[user.level].rendido) rendido.
            """
            showPopup(desc, 203, 217)
        }
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier! == "mainToInvestments"){
            let makeInvestment = segue.destination as! MakeInvestmentViewController
            makeInvestment.money = money
            makeInvestment.investment = investments[clickedPos]
            makeInvestment.arrPos = clickedPos
        }
        
    }
    
    @IBAction func ClickedArea(_ sender: Any) {
        money += 1
        moneyLabel.text = "$ \(Int(money))"
    }
    
    @IBAction func unwindToThisView(segue: UIStoryboardSegue){
        let makeInvestment = segue.source as! MakeInvestmentViewController
        
        let investment = investments[makeInvestment.arrPos]
        investment.firstTime = false
        
        let invMoney = Double(Int(makeInvestment.invMoney))
        
        let rendaAntigaInvestimento = investment.investido + investment.rendido
        
        if(invMoney < rendaAntigaInvestimento){ //tirou dinheiro
            var retirar = rendaAntigaInvestimento - invMoney
            money += retirar
            if(retirar < investment.investido){
                investment.investido -= retirar
                
                investment.investido = (investment.rendido <= 0) ? 0 : investment.investido
            }
            else{
                retirar -= investment.investido
                investment.investido = 0
                investment.rendido -= retirar
                
                investment.rendido = (investment.rendido <= 0) ? 0 : investment.rendido
            }
        }
        else{ //colocou dinheiro
            let colocar =  invMoney - rendaAntigaInvestimento
            money -= colocar
            investment.investido += colocar
        }
 
        moneyLabel.text = "$ \(Int(money))"
        investmentsCollection.reloadData()
        
        print("\(investment.nome) -> \(investment.investido) \(investment.rendido)")
        
        checkErrors()
        
    }
    
    func checkErrors(){
        let errorVariavel = Error.variavel(investments)
        let errorPetroleo = Error.petroleo(investments)
        var desc = ""
        var investimentos:[Investment] = []
        if errorVariavel {
            errorVar = true
            desc = """
            Uma forte crise na bolsa de valores acabou de acontecer e todos que investiram em ações perderam todo seu dinheiro.
            
            Dica: Nunca invista na bolsa mais do que você está disposto a perder.
            """
            for inv in investments {
                if inv.tipoVariavel {
                    investimentos.append(inv)
                }
            }
            
        }
        else if errorPetroleo {
            errorPetr = true
            desc = """
            Crise no Oriente médio. A distribuição de petróleo no mundo foi prejudicada e empresas que dependiam disso estão à beira da falência.
            
            Dica: Nunca invista a maioria do seu dinheiro em empresas do mesmo setor.
            """
            for inv in investments {
                if(inv.nome == "Concha" || inv.nome == "Petromil" || inv.nome == "Gasobras"){
                    investimentos.append(inv)
                }
            }
        }
        diminuirRendimento(investimentos)
        Timer.scheduledTimer(timeInterval: TimeInterval(user.tempoVoltaErro), target: self, selector: #selector(resetRendimentoInvestimentos), userInfo: nil, repeats: false)
        
        if errorPetroleo || errorVariavel {
        popupText.frame.size = CGSize(width: popupText.frame.width, height: 203)
        popupView.frame.size = CGSize(width: popupView.frame.width, height: 217)

        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            self.popupView.alpha = 0.9
            self.closePopup.alpha = 1
            self.popupText.text = desc
            //self.objMoreView.hidden = false
            // Show view with animation
        }, completion: nil)
        }
    }
    
    @objc func resetRendimentoInvestimentos() {
        var investimentos:[Investment] = []
        if errorVar {
            for inv in investments {
                if inv.tipoVariavel {
                    investimentos.append(inv)
                }
            }
        }
        else if errorPetr {
            for inv in investments {
                if(inv.nome == "Concha" || inv.nome == "Petromil" || inv.nome == "Gasobras"){
                    investimentos.append(inv)
                }
            }
        }
        
        for inv in investimentos {
            inv.rendimento = user.investments.filter({ (investimento:Investment) -> Bool in
                inv.nome == investimento.nome
            })[0].initRendimento
        }
        
        investmentsCollection.reloadData()
        
    }
    
    func showPopup(_ text:String,_ textHeight:CGFloat, _ viewHeight: CGFloat){
        popupText.frame.size = CGSize(width: popupText.frame.width, height: textHeight)
        popupView.frame.size = CGSize(width: popupView.frame.width, height: viewHeight)
        
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            self.investmentsCollection.alpha = 0.3
            self.clickButton.alpha = 0.3
            self.moneyView.alpha = 0.3
            self.contaCorrenteLabel.alpha = 0.3
            self.popupView.alpha = 1
            self.closePopup.alpha = 1
            self.popupText.text = text
        }, completion: nil)
    
    }
    @IBAction func onClosePopup(_ sender: Any) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            self.investmentsCollection.alpha = 1
            self.clickButton.alpha = 1
            self.moneyView.alpha = 1
            self.contaCorrenteLabel.alpha = 1
            self.popupView.alpha = 0
            self.closePopup.alpha = 0
        }, completion: nil)
        
    }
    
    

    
    func diminuirRendimento(_ investments: [Investment]) {
        for investment in investments{
            investment.rendimento = -5.0
        }
    }
    

    
    
    
}

