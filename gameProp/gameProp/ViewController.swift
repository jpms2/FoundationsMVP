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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        investmentsCollection.delegate = self
        investmentsCollection.dataSource = self
        
        let investment1 = Investment("moneyPig", "0.6%", 1050.0, 1)
        let investment2 = Investment("imagem", "0.12%", 50.0, 1)
        let investment3 = Investment("imagem", "0.22%", 50.0, 1)
        let investment4 = Investment("imagem", "0.69%", 50.0, 1)
        investments = [investment1,investment2,investment3, investment4]
    }
    
    func makeToast(_ text:String,_ posX:Int,_ posY:Int){
        let pos = CGPoint(x: posX, y: posY)
        var style = ToastStyle()
        //style.activitySize = size
        style.displayShadow = true
        style.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        ToastManager.shared.style = style
        self.view.makeToast(text,duration: 10.0, point: pos, title: "Dica!", image: nil, completion: { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        makeToast("Comece com a poupança!", 210, 220)
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
        cell.investimento.text = "R$ \(investments[indexPath.row].investido)"
        cell.rendimento.text = investments[indexPath.row].rendimento
        
        cell.backgroundColor = #colorLiteral(red: 0.9060912694, green: 0.9060912694, blue: 0.9060912694, alpha: 1).withAlphaComponent(0.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @IBAction func ClickedArea(_ sender: Any) {
        money += 1
        moneyLabel.text = "$ \(money)"
    }
    
}

