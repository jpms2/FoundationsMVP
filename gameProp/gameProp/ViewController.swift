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
    var money = 0
    var swtch = true
    var clickedPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        investmentsCollection.delegate = self
        investmentsCollection.dataSource = self
        
        let investment1 = Investment("Poupança","moneyPig", 1, 0, 1)
        let investment2 = Investment("LCA","LCA", 0.12, 0, 1)
        let investment3 = Investment("LCI","LCI", 0.22, 0, 1)
        let investment4 = Investment("Petrofaz","Oil", 0.69, 0, 1)
        investments = [investment1,investment2,investment3, investment4]
        Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(creditAccount), userInfo: nil, repeats: true)

    }
    
    @objc func creditAccount(){
        var totalGain = 0.0
        for investment in investments{
            totalGain += Double(investment.investido) * (investment.rendimento/100)
        }
        money += Int(totalGain)
        moneyLabel.text = "$ \(money)"
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
        cell.investimento.text = "$ \(investments[indexPath.row].investido)"
        cell.rendimento.text = "\(investments[indexPath.row].rendimento)%"
        
        cell.backgroundColor = #colorLiteral(red: 0.9060912694, green: 0.9060912694, blue: 0.9060912694, alpha: 1).withAlphaComponent(0.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedPos = indexPath.row
        performSegue(withIdentifier: "mainToInvestments", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier! == "mainToInvestments"){
            let makeInvestment = segue.destination as! MakeInvestmentViewController
            makeInvestment.money = money + investments[clickedPos].investido
            makeInvestment.invName = investments[clickedPos].nome
            makeInvestment.invYeld = "\(investments[clickedPos].rendimento)%"
            makeInvestment.arrPos = clickedPos
        }
        
    }
    
    @IBAction func ClickedArea(_ sender: Any) {
        money += 1
        moneyLabel.text = "$ \(money)"
    }
    
    @IBAction func unwindToThisView(segue: UIStoryboardSegue){
        let makeInvestment = segue.source as! MakeInvestmentViewController
        
        if (makeInvestment.invMoney < investments[makeInvestment.arrPos].investido) {
            money += investments[makeInvestment.arrPos].investido - makeInvestment.invMoney
        }else{
            money -= makeInvestment.invMoney - investments[makeInvestment.arrPos].investido
        }
        moneyLabel.text = "$ \(money)"
        if makeInvestment.invMoney < 0 {
            investments[makeInvestment.arrPos].investido = 0
        }else{
            investments[makeInvestment.arrPos].investido = makeInvestment.invMoney
        }
        
        investmentsCollection.reloadData()
    }
}

