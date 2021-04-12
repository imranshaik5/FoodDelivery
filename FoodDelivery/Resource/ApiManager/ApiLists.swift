//
//  ApiLists.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit

import Foundation

// @@@@@@@@ MARK:- Typealias @@@@@@@@@@

typealias ApiResponse = (status:Status,data:Any,message:String)
typealias ApiData = (data:Data, response:URLResponse?)

enum Result<T:Decodable> {
    case success(data:T) //Success response
    case failure(message:String)//APi call error
    case error(message:String) //Network error
}

enum ApiStatus {
    case NoData
    case NetworkError
    case Success
    case Error
    case Failure
}



// @@@@@@@@ MARK:- Enum @@@@@@@@@@

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum Status{
    case success,failure
}


enum Endpoints:String {
    
    case getGeoCode = "/api/v2.1"

    /*
     Stagging
     */
    
//    https://developers.zomato.com/api/v2.1/geocode?lat=12.97&lon=12.97&count=100
    static var baseURL = "https://developers.zomato.com"
    
}




enum StatusCode:Int {
    case success = 200
    case accepted = 202
    case error = 204
    case validation = 422
    case notFound = 404
    case badRequest = 400
    case bad = 503
    case logout = 401
    case noInternet = 0
    case internalServerError = 500
}

protocol APIResponseDelegate {
    func onSuccess()
    func onFailure(message:String)
}




