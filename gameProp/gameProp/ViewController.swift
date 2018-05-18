//
//  ViewController.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 07/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit
import Toast_Swift
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var moneyView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupText: UILabel!
    @IBOutlet weak var closePopup: UIButton!
    
    @IBOutlet weak var contaCorrenteLabel: UILabel!
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var contaLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var investmentsCollection: UICollectionView!
    var investments = [Investment]()
    var money = 0.0
    var clickedPos = 0
    var user = User()
    var errorVarTime = false
    var errorPetrTime = false
    var errorTransAirTime = false
    var errorMedcareTime = false
    
    var coinSound = Bundle.main.path(forResource: "coins_sound", ofType: "wav")
    var levelupSound = Bundle.main.path(forResource: "levelup_sound", ofType: "wav")
    var coinPlayer = AVAudioPlayer()
    var levelupPlayer = AVAudioPlayer()
    
    func initValues(){
        investmentsCollection.delegate = self
        investmentsCollection.dataSource = self
        setupMoneyDesign()
        setupPopupDesign()
        money = user.money
        investments = user.investments
        
        initTimers()
        initAudioPlayers()
        
        //test()
        let color = user.azulEscuro
        moneyLabel.text = "$ \(Int(money))"
        moneyLabel.textColor = color
        contaLabel.textColor = color
    }
    
    func initAudioPlayers(){
        do {
            coinPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: coinSound!))
            levelupPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: levelupSound!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            print(error)
        }
        
    }
    
    
    func setupMoneyDesign(){
        moneyView.layer.borderWidth = 2.0
        moneyView.layer.borderColor = user.azulClaro.cgColor
        moneyView.layer.cornerRadius = 20
    }
    
    func setupPopupDesign(){
        popupView.alpha = 0
        closePopup.alpha = 0
        popupView.layer.cornerRadius = 20
        popupView.layer.borderWidth = 2.0
        popupView.layer.borderColor = user.azulClaro.cgColor
    }
    
    func test(){
        money = 1000
        moneyLabel.text = "$ \(Int(money))"
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValues()
        
    }
    
    func timer( _ interval: Int, _ selector: Selector){
        Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    func tryNextLevel() {
        if(investments[user.level].rendido >= user.objectives[user.level]){
            user.updateLevel()
            levelupPlayer.play()
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
            let desc = "Parabéns, seu dinheiro investido em \(investments[user.level-1].nome) rendeu $ \(user.objectives[user.level-1])\nAgora você desbloqueou \(investments[user.level].nome)!"
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
        
        if(invest.tipoVariavel){
            let colorVariavel = user.azulEscuro
            cell.nome.textColor = colorVariavel
            cell.rendimentoLabel.textColor = colorVariavel
            cell.investimentoLabel.textColor = colorVariavel
            cell.investimento.textColor = colorVariavel
            
        }
        else{
            let colorVariavel = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.nome.textColor = colorVariavel
            cell.rendimentoLabel.textColor = colorVariavel
            cell.investimentoLabel.textColor = colorVariavel
            cell.investimento.textColor = colorVariavel
            
        }
        
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

            Para passar de nível é necessário ter uma quantia rendida de $ \(user.objectives[user.level]) em \(investments[user.level].nomeAbreviado)
            Atualmente você possui
            $ \(Int(investments[user.level].rendido)) rendido.
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
        coinPlayer.play()
        animateButton()
    }
    
    func animateButton(){
        UIView.animate(withDuration: 0.2, animations: {
            self.clickButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)},
               completion: { _ in UIView.animate(withDuration: 0.2){
                self.clickButton.transform = CGAffineTransform.identity
                
                }
        })
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
        let errorVariavel = Error.variavel(investments,money)
        let errorPetroleo = Error.petroleo(investments,money)
        let errorTransAir = Error.aleatorio()
        let errorMedcare = Error.aleatorio()
        var desc = ""
        var investimentos:[Investment] = []
        if errorVariavel {
            errorVarTime = true
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
            errorPetrTime = true
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
        else if (errorTransAir && user.level >= 4) {
            errorTransAirTime = true
            desc = """
            Um avião acaba de cair no triângulo das bermudas! Por conta do acidente a maioria dos acionistas venderam suas ações e a empresa está próxima da falência
            
            Dica: Nunca invista a maior parte de seu dinheiro na mesma empresa
            divida bem seus investimentos
            """
            for inv in investments {
                if inv.nome == "Medcare" {
                    investimentos.append(inv)
                }
            }
        }
        else if (errorMedcare && user.level >= 8) {
            errorMedcareTime = true
            desc = """
            Uma mulher desconhecida acaba de roubar cinco bebês da maternidade, deixando os investidores receosos
            
            Dica: Nunca invista a maior parte de seu dinheiro na mesma empresa
            divida bem seus investimentos
            """
            for inv in investments {
                if inv.nome == "Medcare" {
                    investimentos.append(inv)
                }
            }
        }
        diminuirRendimento(investimentos)
        Timer.scheduledTimer(timeInterval: TimeInterval(user.tempoVoltaErro), target: self, selector: #selector(resetRendimentoInvestimentos), userInfo: nil, repeats: false)
        
        if errorPetroleo || errorVariavel {
        popupText.frame.size = CGSize(width: popupText.frame.width, height: 203)
        popupView.frame.size = CGSize(width: popupView.frame.width, height: 217)

        popupView.layer.borderColor = UIColor.red.cgColor
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
        if errorVarTime{
            for inv in investments {
                if inv.tipoVariavel {
                    investimentos.append(inv)
                }
            }
        }
        else if errorPetrTime {
            for inv in investments {
                if(inv.nome == "Concha" || inv.nome == "Petromil" || inv.nome == "Gasobras"){
                    investimentos.append(inv)
                }
            }
        }
        else if errorTransAirTime {
            for inv in investments {
                if(inv.nome == "TransAir"){
                    investimentos.append(inv)
                }
            }
        }
        else if errorMedcareTime {
            for inv in investments {
                if(inv.nome == "Medcare"){
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
        popupView.layer.borderColor = user.azulClaro.cgColor
        
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
    
    
    @IBAction func clickTest(_ sender: Any) {
        test()
    }
    
    
    func diminuirRendimento(_ investments: [Investment]) {
        for investment in investments{
            investment.rendimento = -5.0
        }
    }
    

    
    
    
}

