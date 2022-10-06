//
//  PetTableViewCell.swift
//  ClinicConnect
//
//  Created by Macbook on 07/10/22.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblPetName: UILabel!
    @IBOutlet weak var imgPet: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(pets: Pets?) {
        lblPetName.text = pets?.title
        imgPet.loadImageUsingCache(withUrl: pets?.image_url ?? "")
    }
}
