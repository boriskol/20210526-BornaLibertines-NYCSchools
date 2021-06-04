//
//  SchoolService.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 6/4/21.
//


import Foundation
import Combine



private struct Domain {
    static let scheme = "https"
    static let host = "data.cityofnewyork.us"
    static let path = "/resource/s3k6-pzi2.json"
    static let pathdbn = "/resource/f9bf-2cp4.json"
}

public class SchoolsApi: SchoolsProvider {
   
    private let baseURL = "https://data.cityofnewyork.us"
    private enum Endpoint: String {
        case allSchools = "/resource/s3k6-pzi2.json"
        case search = "/resource/f9bf-2cp4.json"
    }
    private enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    public init() {}
    

    // MARK: Combine
    
    public func getAllSchools<T: Codable>() -> AnyPublisher<[T], APIError> {
        return call(.allSchools, method: .GET, school: nil)
    }
    func getSchool<T: Codable>(school: School) -> AnyPublisher<[T], APIError> {
        return call(.search, method: .GET, school: school)
    }
    
    private func call<T: Codable>(_ endPoint: Endpoint, method: Method, school: School?) -> AnyPublisher<[T], APIError> {
        let urlRequest = request(for: endPoint, method: method, school: school)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError{ _ in APIError.serverError }
            .map { $0.data }
            .decode(type: [T].self, decoder: JSONDecoder())
            .mapError { _ in APIError.parsingError }
            .eraseToAnyPublisher()
    }
    
    private func request(for endpoint: Endpoint, method: Method, school: School?) -> URLRequest {
        
        if school != nil{
            guard let dbn = school?.dbn else {preconditionFailure("Bad URL")}
            let path = "\(baseURL)\(endpoint.rawValue)?dbn=\(String(describing: dbn))"
            guard let url = URL(string: path) else { preconditionFailure("Bad URL") }
            //debugPrint(url.absoluteString)
            var request = URLRequest(url: url)
            request.httpMethod = "\(method)"
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            return request
        }else{
            let path = "\(baseURL)\(endpoint.rawValue)"
            guard let url = URL(string: path)
                else { preconditionFailure("Bad URL") }
            
            var request = URLRequest(url: url)
            request.httpMethod = "\(method)"
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            return request
        }
        
    }
    
}
