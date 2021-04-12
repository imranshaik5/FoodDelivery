//
//  HomeCollectionViewCell.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var opacityView: UIView!
    @IBOutlet weak var titleLabelText: UILabel!
    @IBOutlet weak var subTitleLabelText: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cellConfigure(data: ProductDetails){
        productImage.image = data.image
        titleLabelText.text = data.mainDescription
        subTitleLabelText.text = data.subDescription
        productNameLabel.text = data.name
        opacityView.backgroundColor = data.backgroundColor
    }

}
