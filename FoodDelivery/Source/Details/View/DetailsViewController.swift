//
//  DetailsViewController.swift
//  FoodDelivery
//
//  Created by imran shaik on 12/04/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cusinTypeLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    var hotelImage = String()
    var hotelName = String()
    var ratingText = String()
    var cusineText = String()
    var reviewCount = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotelImageView.setImage(with: hotelImage, placeHolder: #imageLiteral(resourceName: "placeholder"))
        hotelNameLabel.text = hotelName
        ratingLabel.text = ratingText
        cusinTypeLabel.text = cusineText
        reviewCountLabel.text = reviewCount
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
