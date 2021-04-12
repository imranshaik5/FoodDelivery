//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationButton: UIButton!
    var viewModel = HomeViewModel()
    var model = [Nearby_restaurants]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        locationButton.setTitle(model.first?.restaurant.location.city, for: .normal)
        registerTableNib(table: tableView) { (status) in
//            self.viewModel.delegate = self
            self.tableView.reloadData()
        }
                
    }
    
    func registerTableNib(table: UITableView, completion: @escaping(_ status: Bool) -> ()) {
        table.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionTableViewCell")
        table.register(UINib(nibName: "TitleHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleHeaderTableViewCell")
        table.register(UINib(nibName: "RestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurantsTableViewCell")
        
        table.dataSource = self
        table.delegate = self
        completion(true)
        viewModel.apiGetResturants(params: [:]) { (status, resturant) in
            if status == .Success{
                if let resturants = resturant{
                    self.model.append(contentsOf: resturants )
                    self.locationButton.setTitle("\(resturant?.first?.restaurant.location.city ?? ""),\(resturant?.first?.restaurant.location.locality ?? "")", for: .normal)
                    table.reloadData()
                }
            } else {
                debugPrint(self.viewModel.errorMessage)
            }
        }
    }
    
    @IBAction func onLocationButtonTap(_ sender: Any) {
    }
    
    @IBAction func onFilterButtonTap(_ sender: Any) {
    }
    

}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        default:
            return model.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as? CollectionTableViewCell else {
           return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
           
        case 1:
            guard let headerView = tableView.dequeueReusableCell(withIdentifier: "TitleHeaderTableViewCell") as? TitleHeaderTableViewCell else {
                return UITableViewCell()
            }
            headerView.selectionStyle = .none
            return headerView
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantsTableViewCell") as? RestaurantsTableViewCell else{
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.cellconfiguration(data: model[indexPath.row])
            cell.shadowView.layer.applySketchShadow(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), alpha: 0.6, x: 15, y: 15, blur: 14, spread: 100)
            cell.tag = indexPath.row
//            cell.shadowView.addShadow(offset: CGSize(width: 0, height: 0), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), opacity: 0.40, radius: 4)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            vc.hotelImage = model[indexPath.row].restaurant.featuredImage
            vc.hotelName = model[indexPath.row].restaurant.name
            vc.ratingText = "\(model[indexPath.row].restaurant.userRating.aggregateRating)"
            vc.cusineText = model[indexPath.row].restaurant.cuisines
            vc.reviewCount = "\(model[indexPath.row].restaurant.userRating.votes)"
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        case 1:
            return UITableView.automaticDimension
        default :
            return 180
            
            
        }
        
    }
    
    
}

