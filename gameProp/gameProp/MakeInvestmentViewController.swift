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
    @IBOutlet weak var tempoRendimentoImg: UIImageView!
    @IBOutlet weak var rendimentoImg: UIImageView!
    
    @IBOutlet weak var investmentInfoPopup: UIView!
    @IBOutlet weak var investmentYeld: UILabel!
    @IBOutlet weak var currentMoney: UILabel!
    @IBOutlet weak var investmentSlider: UISlider!
    @IBOutlet weak var barraInitialPosSlider: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    var investment:Investment = Investment()
    var invMoney = 0.0
    var money = 0.0
    var arrPos = 0
    let user = User()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        // Do any additional setup after loading the view.
        
        
        tempoRendimentoImg.image = tempoRendimentoImg.image!.withRenderingMode(.alwaysTemplate)
        tempoRendimentoImg.tintColor = user.azulEscuro
        
        rendimentoImg.image = rendimentoImg.image!.withRenderingMode(.alwaysTemplate)
        rendimentoImg.tintColor = user.azulEscuro
        
        investmentYeld.text = "\(String(format: "%.2f", investment.rendimento)) %"
        infoTime.text = "\(investment.tipoVariavel ? user.tempoRendimentoVariavel : user.tempoRendimentoFixo)s"
        invMoney = investment.investido + investment.rendido
        currentMoney.text = "$ \(Int(invMoney)).00"
        handlePopupFirstTime()
        setSlider()
        arrangeBarraInitialPosSlider()
        handleInvestmentPopup()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = user.azulClaro
        self.title = self.investment.nome
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "question"), style: .plain, target: self, action: #selector(self.showInfo)), animated: false)
    }
    
    func handleInvestmentPopup(){
        investmentInfoPopup.layer.cornerRadius = 20
        investmentInfoPopup.alpha = 0
        infoText.text = "\(investment.descricao)"
        infoHowToInvest.text = "\(investment.aprenda)"
        investmentInfoPopup.layer.borderWidth = 2.0
        investmentInfoPopup.layer.borderColor = user.azulClaro.cgColor
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
    
    @IBAction func showInfo() {
        if(investmentInfoPopup.alpha == 0){
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
                self.investmentInfoPopup.alpha = 1
            }, completion: nil)
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "cancel"), style: .plain, target: self, action: #selector(self.showInfo)), animated: false)
        }
        else {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.transitionCurlDown, animations: {
                self.investmentInfoPopup.alpha = 0
            }, completion: nil)
            self.navigationItem.setRightBarButton(UIBarButtonItem(image: #imageLiteral(resourceName: "question"), style: .plain, target: self, action: #selector(self.showInfo)), animated: false)
        }
        
    }
    
    @IBAction func investmentSliderChange(_ sender: Any) {
        invMoney = Double(investmentSlider.value)
        currentMoney.text = "$ \(Int(invMoney)).00"
        
    }
    
    @IBAction func investGoBack(_ sender: Any) {
        //TODO
        dismiss(animated: true, completion: nil)
    }
    

}
