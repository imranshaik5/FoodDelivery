//
//  CollectionTableViewCell.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    var model = [ProductDetails]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initilizeUI()
        homeCollectionView.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initilizeUI(){
        model.removeAll()
        model.append(ProductDetails(image: #imageLiteral(resourceName: "ice cream"), name: "The obroma", mainDescription: "40%", subDescription: "Off", backgroundColor: #colorLiteral(red: 0.4037945271, green: 0.1884527802, blue: 0.5592746735, alpha: 0.7)))
        model.append(ProductDetails(image: #imageLiteral(resourceName: "H&M"), name: "H & M", mainDescription: "Buy 1", subDescription: "Get 1 Free", backgroundColor: #colorLiteral(red: 0.9273902774, green: 0.2473702133, blue: 0.4762758613, alpha: 0.7)))
        model.append(ProductDetails(image: #imageLiteral(resourceName: "Hotel"), name: "Taj Hotel", mainDescription: "₹1000", subDescription: "CashBack", backgroundColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.7)))
        
    }
    
    
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellConfigure(data: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 170, height: 170)
      }
    
    
}
