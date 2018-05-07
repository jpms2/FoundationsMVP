//
//  variavelTableViewCell.swift
//  gameProp
//
//  Created by João Pedro de Medeiros Santos on 07/05/18.
//  Copyright © 2018 João Pedro de Medeiros Santos. All rights reserved.
//

import UIKit

class variavelTableViewCell: UITableViewCell {

    @IBOutlet weak var imagemVariavel: UIImageView!
    @IBOutlet weak var investimentoVariavel: UILabel!
    @IBOutlet weak var rendimentoVariavel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
