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
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var investmentsCollection: UICollectionView!
    var investments = [Investment]()
    var money = 0.0
    var clickedPos = 0
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        investmentsCollection.delegate = self
        investmentsCollection.dataSource = self
        money = user.money
        investments = user.investments
  
        
        timer(3, #selector(creditRendaFixa))
        timer(1, #selector(creditRendaVariavel))
        timer(1, #selector(updateRendimento))
    }
    func timer(_ interval:Int,_ selector: Selector){
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: selector, userInfo: nil, repeats: true)
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
            if(investment.tipoVariavel && investment.locked){
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
    }
    
    
    func makeToast(_ text:String,_ posX:Int,_ posY:Int){
        let pos = CGPoint(x: posX, y: posY)
        var style = ToastStyle()
        //style.activitySize = size
        style.displayShadow = true
        style.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        ToastManager.shared.style = style
        self.view.makeToast(text,duration: 10.0, point: pos, title: "Dica!", image: nil, completion: { didTap in
        })
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
        if(investments[clickedPos].locked){
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
}

