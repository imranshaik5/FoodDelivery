//
//  RestaurantsTableViewCell.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit

class RestaurantsTableViewCell: UITableViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var hotelNamelabel: UILabel!
    @IBOutlet weak var availableCusineLabel: UILabel!
    @IBOutlet weak var costforTwoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func cellconfiguration(data:Nearby_restaurants){
        foodImageView.setImage(with: data.restaurant.featuredImage, placeHolder: #imageLiteral(resourceName: "placeholder"))
        hotelNamelabel.text = data.restaurant.name
        availableCusineLabel.text = data.restaurant.cuisines
        costforTwoLabel.text = "Cost for two ₹\(data.restaurant.average_cost_for_two ) approx "
    }
    
}
