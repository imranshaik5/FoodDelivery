//
//  HomeViewModel.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit

class HomeViewModel: NSObject {
    var errorMessage = String()
    var model = [Nearby_restaurants]()
    var restaurentsModel = [Restaurant]()
    
    func apiGetResturants(params:DictionaryType,completion:@escaping(_ status: ApiStatus,_ data :[Nearby_restaurants]?)-> ()){
        
        let url = Endpoints.getGeoCode.rawValue + "/geocode?lat=12.97&lon=12.97&limit=100"
            
//            "?&orderStatus=\(orderStatus)&orderType=\(orderType)&page=\(page)&limit=20"
//            https://developers.zomato.com/api/v2.1/geocode?lat=12.97&lon=12.97&count=100

        
        ApiRequest.sharedInstance.apiRequest(baseUrl: Endpoints.baseURL, url: url, parameter: params, method: .get) { (status:Result<HomeModel>) in
            switch status {
            case .success(let data):
                completion(.Success,data.nearby_restaurants)
            case .failure(let message):
                self.errorMessage = message
                completion(.Failure,nil)
            case .error(let message):
                self.errorMessage = message
                completion(.Error,nil)
            }
        }
    }


}

