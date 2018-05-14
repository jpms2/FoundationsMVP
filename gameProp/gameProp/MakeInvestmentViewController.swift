//
//  MakeInvestmentViewController.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 10/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit
import Toast_Swift

class MakeInvestmentViewController: UIViewController {

    @IBOutlet weak var investmentName: UILabel!
    @IBOutlet weak var investmentYeld: UILabel!
    @IBOutlet weak var currentMoney: UILabel!
    var investment:Investment = Investment()
    var firstTime = false
    var invMoney = 0.0
    var money = 0.0
    var arrPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        investmentYeld.text = "\(String(format: "%.2f", investment.rendimento))%"
        investmentName.text = "\(investment.nome)"
        invMoney = money + investment.investido + investment.rendido
        currentMoney.text = "$ \(Int(invMoney))"
        if (firstTime) {
            makeToast("Dica!", "Aqui você pode investir ou retirar seus investimentos")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func investGoBack(_ sender: Any) {
        //TODO
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addMoney(_ sender: Any) {
        if((invMoney + 100) < money){
            invMoney += 100
            currentMoney.text = "$ \(Int(invMoney))"
        }else{
            makeToast("Dica!", "Lembre de nunca investir tudo que tem, você tem contas para pagar no fim do mês!")
            invMoney = money
            currentMoney.text = "$ \(Int(invMoney))"
        }
    }
    
    @IBAction func takeMoney(_ sender: Any) {
        if((invMoney - 100) >= 0){
            invMoney -= 100
            currentMoney.text = "$ \(Int(invMoney))"
        }else{
            invMoney = 0
            currentMoney.text = "$ \(Int(invMoney))"
        }
    }
    
    func makeToast(_ title:String,_ text:String){
        var style = ToastStyle()
        //style.activitySize = size
        style.displayShadow = true
        style.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ToastManager.shared.style = style
        self.view.makeToast(text,duration: 3.0, position: .center, title: title, image: nil, completion: { didTap in
            
        })
    }
}
