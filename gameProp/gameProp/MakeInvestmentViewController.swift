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
    
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var infoHowToInvest: UILabel!
    @IBOutlet weak var infoTime: UILabel!
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var investmentInfoPopup: UIView!
    @IBOutlet weak var investmentName: UILabel!
    @IBOutlet weak var investmentYeld: UILabel!
    @IBOutlet weak var currentMoney: UILabel!
    @IBOutlet weak var investmentSlider: UISlider!
    @IBOutlet weak var barraInitialPosSlider: UIView!
    
    var investment:Investment = Investment()
    var invMoney = 0.0
    var money = 0.0
    var arrPos = 0
    let user = User()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        // Do any additional setup after loading the view.
        investmentYeld.text = "\(String(format: "%.2f", investment.rendimento)) %"
        investmentName.text = "\(investment.nome)"
        infoTime.text = "\(investment.tipoVariavel ? user.tempoRendimentoVariavel : user.tempoRendimentoFixo) segundos"
        invMoney = investment.investido + investment.rendido
        currentMoney.text = "$ \(Int(invMoney))"
        
        handlePopupFirstTime()
        setSlider()
        arrangeBarraInitialPosSlider()
        handleInvestmentPopup()
        
    }
    func handleInvestmentPopup(){
        investmentInfoPopup.layer.cornerRadius = 20
        investmentInfoPopup.alpha = 0
        infoText.text = "\(investment.descricao)"
        infoHowToInvest.text = "\(investment.aprenda)"
        investmentInfoPopup.layer.borderWidth = 2.0
        investmentInfoPopup.layer.borderColor = UIColor(red: 65.0/255.0, green: 187.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
    }
    
    func arrangeBarraInitialPosSlider(){
        barraInitialPosSlider.layer.cornerRadius = 20
        let xPos = (investmentSlider.maximumValue > 0) ?
            CGFloat( Float(investmentSlider.frame.origin.x) +
                ((investmentSlider.value/investmentSlider.maximumValue) * Float(investmentSlider.frame.width)))
            : investmentSlider.frame.origin.x
        
        barraInitialPosSlider.frame.origin = CGPoint(x: xPos, y: barraInitialPosSlider.frame.origin.y)
    }
    
    func setSlider(){
        investmentSlider.minimumValue = 0
        investmentSlider.maximumValue = Float(money + investment.rendido + investment.investido)
        investmentSlider.value = Float(investment.rendido + investment.investido)
    }
    
    func handlePopupFirstTime(){
        if (investment.firstTime) {
            let popup = Popup()
            popup.makeToast(self,"Dica!", investment.descricao,position: .center, image: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showInfo(_ sender: Any) {
        if(investmentInfoPopup.alpha == 0){
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
                self.investmentInfoPopup.alpha = 1
                self.investmentName.alpha = 0.3
                //self.objMoreView.hidden = false
                // Show view with animation
            }, completion: nil)
            let image = UIImage(named: "cancel")
            infoButton.setImage(image, for: UIControlState.normal)
        }
        else {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
                self.investmentInfoPopup.alpha = 0
                self.investmentName.alpha = 1
                //self.objMoreView.hidden = false
                // Show view with animation
            }, completion: nil)
            let image = UIImage(named: "info")
            infoButton.setImage(image, for: UIControlState.normal)
        }
        
    }
    
    @IBAction func investmentSliderChange(_ sender: Any) {
        invMoney = Double(investmentSlider.value)
        currentMoney.text = "$ \(Int(invMoney))"
        
    }
    
    @IBAction func investGoBack(_ sender: Any) {
        //TODO
        dismiss(animated: true, completion: nil)
    }
    

}
