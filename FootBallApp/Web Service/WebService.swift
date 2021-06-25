//
//  WebService.swift
//  FootBallApp
//
//  Created by Neria Jerafi on 21/06/2021.
//

import Foundation
import Alamofire
import SVGKit

// MARK:- Web Service Error enum
enum WebServiceError:Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

struct WebService {
    // MARK:- Properties
    static let baseURLString = "https://api.football-data.org/v2"
    static let headers = HTTPHeaders([HTTPHeader(name: "X-Auth-Token", value: "32b3e27da1ef49848042a925974e71af")])
    
    // MARK:- Query params methods
    static func  getAreasFilterString(areasIDArray:[String] = ["2072"]) -> String {
       let  filterString = areasIDArray.joined(separator:",")
        print("?areas=\(filterString)")
        return "?areas=\(filterString)"
    }
    
   static func getUpcomingMatchesDetailsFilterString() -> String {
    let dateFilter = DateUtils.shared.startEndDateFilter()
    return "?dateFrom=\(dateFilter.start)&dateTo=\(dateFilter.end)&status=SCHEDULED"
    }
    
    // MARK:- Request methods
    static func getRequest<T:Codable>(stringURL:String ,completion:@escaping(Result<T,WebServiceError>) ->()){
        guard let url = URL(string: stringURL) else { return }
        AF.request(url,headers: headers).response { (result) in
            guard result.error == nil else{ completion(.failure(.clientError))
                return }
            guard let response = result.response, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            guard let data = result.data else {
                completion(.failure(.noData))
                return
            }
            guard let decodedData: T = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.dataDecodingError))
                return
            }
            completion(.success(decodedData))
        }
    }
    
    static func imageLoader(stringURL:String, completion:@escaping(Result<UIImage,WebServiceError>)->()){
        guard let url = URL(string: stringURL) else { return }
        AF.request(url).responseData { (result) in
            guard result.error == nil else{ completion(.failure(.clientError))
                return }
            guard let response = result.response, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            guard let data = result.data else {
                completion(.failure(.noData))
                return
            }
            var image: UIImage?
            if url.absoluteString.hasSuffix("svg") {
                image = SVGKImage(data: data)?.uiImage
            } else {
                image = UIImage(data: data)
            }
            
            guard let finalImage = image else {
                completion(.failure(.noData))
                return }
            completion(.success(finalImage))
        }
    }
}

