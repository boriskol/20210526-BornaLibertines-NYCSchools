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
   
    private enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    public init() {}
    

    // MARK: Combine
    
    public func getAllSchools<T: Codable>() -> AnyPublisher<[T], APIError> {
        return call(method: .GET, school: nil)
    }
    func getSchool<T: Codable>(school: School) -> AnyPublisher<[T], APIError> {
        return call(method: .GET, school: school)
    }
    
    private func call<T: Codable>(method: Method, school: School?) -> AnyPublisher<[T], APIError> {
        let urlRequest = request(method: method, school: school)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError{ _ in APIError.serverError }
            .map { $0.data }
            .decode(type: [T].self, decoder: JSONDecoder())
            .mapError { _ in APIError.parsingError }
            .eraseToAnyPublisher()
    }
    
    private func request(method: Method, school: School?) -> URLRequest {
        
        if school != nil{
            guard let dbn = school?.dbn else {preconditionFailure("Bad URL")}
            var queryItems = [URLQueryItem]()
            queryItems.append(URLQueryItem(name: "dbn", value: dbn))
            var components = URLComponents()
            components.scheme = Domain.scheme
            components.host = Domain.host
            components.path = Domain.pathdbn
            components.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let url = components.url else { preconditionFailure("Bad URL") }
            var request = URLRequest(url: url)
            request.httpMethod = "\(method)"
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            return request
        }else{
            var components = URLComponents()
            components.scheme = Domain.scheme
            components.host = Domain.host
            components.path = Domain.path
            guard let url = components.url else { preconditionFailure("Bad URL") }
            
            var request = URLRequest(url: url)
            request.httpMethod = "\(method)"
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            return request
        }
        
    }
    
}
