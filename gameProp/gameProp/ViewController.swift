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
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupText: UILabel!
    @IBOutlet weak var closePopup: UIButton!
    
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var investmentsCollection: UICollectionView!
    var investments = [Investment]()
    var money = 0.0
    var clickedPos = 0
    var user = User()
    
    func initValues(){
        investmentsCollection.delegate = self
        investmentsCollection.dataSource = self
        money = user.money
        investments = user.investments
        
        timer(3, #selector(creditRendaFixa))
        timer(1, #selector(creditRendaVariavel))
        timer(1, #selector(updateRendimento))
        
        popupView.alpha = 0
        closePopup.alpha = 0
        popupView.layer.cornerRadius = 20
        money = user.money
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValues()
        
        let popup = Popup()
        popup.makeToast(self, "Olá, bem vindo!", user.startText, position: .center, image: nil)
        
    }
    
    func timer(_ interval:Int,_ selector: Selector){
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func tryNextLevel() {
        if(investments[user.level].rendido >= user.objectives[user.level]){
            user.updateLevel()
            dalePopup()
        }
    }
    
    func dalePopup() {
        var desc = "Agora você desbloqueou um novo investimento!"
        
        if(user.level == 2){
            desc = user.ipcaSelic
            popupText.frame.size = CGSize(width: popupText.frame.width, height: 366)
            popupView.frame.size = CGSize(width: popupView.frame.width, height: 374)
        }
        else if (user.level == 4){
            desc = user.rendaCompare
            popupText.frame.size = CGSize(width: popupText.frame.width, height: 203)
            popupView.frame.size = CGSize(width: popupView.frame.width, height: 217)
        }
        else{
            popupText.frame.size = CGSize(width: popupText.frame.width, height: 94)
            popupView.frame.size = CGSize(width: popupView.frame.width, height: 103)
            
        }
        //let popup = Popup()
        //popup.makeToast(self, "Parabéns, você passou de nível!!", desc, position: .center, image: nil)
    
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            self.popupView.alpha = 1
            self.closePopup.alpha = 1
            self.popupText.text = desc
            //self.objMoreView.hidden = false
            // Show view with animation
        }, completion: nil)
        //let image = UIImage(named: "cancel")
        //infoButton.setImage(image, for: UIControlState.normal)
    }
    
    @objc func creditRendaFixa(){
        for investment in investments{
            if(!investment.tipoVariavel && !investment.locked){
                investment.rendido += (investment.investido + investment.rendido) * (investment.rendimento/100)
            }
        }
        investmentsCollection.reloadData()
    }
    @objc func creditRendaVariavel(){
        for investment in investments{
            if(investment.tipoVariavel && !investment.locked){
                investment.rendido += (investment.investido + investment.rendido)  * (investment.rendimento/100)
                if(investment.nome == "Medcare"){
                    //print("\(investment.investido) - \(investment.rendido) - \(investment.rendimento/100)")
                }
            }
            
        }
        investmentsCollection.reloadData()
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
        let cell:InvestmentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "investmentCell", for: indexPath) as! InvestmentCollectionViewCell
        let image = UIImage(named: investments[indexPath.row].image)
        cell.image.image = image
        cell.investimento.text = "$ \(Int(investments[indexPath.row].investido) + Int(investments[indexPath.row].rendido))"
        cell.rendimento.text = "\(String(format: "%.2f", investments[indexPath.row].rendimento))%"
        cell.nome.text = investments[indexPath.row].nomeAbreviado
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.0)
        
        if(investments[indexPath.row].rendimento > 0){
            cell.rendimento.textColor = UIColor.green
        }
        else if (investments[indexPath.row].rendimento < 0){
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
        
        let invMoney = makeInvestment.invMoney
        
        let rendaAntigaInvestimento = investment.investido + investment.rendido
        
        if(invMoney < rendaAntigaInvestimento){ //tirou dinheiro
            var retirar = rendaAntigaInvestimento - invMoney
            money += retirar
            if(retirar < investment.investido){
                investment.investido -= retirar
            }
            else{
                retirar -= investment.investido
                investment.investido = 0
                investment.rendido -= retirar
            }
        }
        else{ //colocou dinheiro
            let colocar =  invMoney - rendaAntigaInvestimento
            money -= colocar
            investment.investido += colocar
        }
 
        moneyLabel.text = "$ \(Int(money))"
        investmentsCollection.reloadData()
        
    }
    
    
    @IBAction func onClosePopup(_ sender: Any) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
            self.popupView.alpha = 0
            self.closePopup.alpha = 0
        }, completion: nil)
    }
    
    
}

