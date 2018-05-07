//
//  ViewController.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 07/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableFixa: UITableView!
    @IBOutlet weak var tableVariavel: UITableView!
    var investments = [Investment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableFixa.dataSource = self
        tableVariavel.dataSource = self
        investments = []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return investments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        makeToast("Comece com a poupança!", 100, 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

