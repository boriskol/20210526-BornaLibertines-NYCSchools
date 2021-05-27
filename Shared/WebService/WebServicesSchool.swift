//
//  WebServicesSchool.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, unknown, error
}

class WebServiceSchool {

    private func getSearchURL(dbn: String) -> URL? {
        var components = URLComponents()
        components.scheme = Domain.scheme
        components.host = Domain.host
        if dbn.isEmpty{
        components.path = Domain.path
        }else{
        components.path = Domain.pathdbn
        }
        components.queryItems = [URLQueryItem]()
        if !dbn.isEmpty{
        components.queryItems?.append(URLQueryItem(name: "dbn", value: dbn))
        }
        return components.url
    }
    
    public func parseListSchools(complition: @escaping(Result<[School], NetworkError>) -> ()){
        
        let request = getSearchURL(dbn: "")
        guard let request = request else {
            DispatchQueue.main.async {
                complition(.failure(.badURL))
            }
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                guard let data = data,
                    let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode,
                    error == nil else {
                    DispatchQueue.main.async {
                        debugPrint("WebServiceSchool \(error.debugDescription)")
                        complition(.failure(.requestFailed))
                    }
                    return
                }
                
                let decodedResponse = try JSONDecoder().decode([School].self, from: data)
                let sor = decodedResponse.sorted {return $0.zip! < $1.zip!}
                    DispatchQueue.main.async {
                        complition(.success(sor))
                    }
                   

            } catch {
                debugPrint("Creation failed with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    complition(.failure(.error))
                }
            }
        }.resume()
    }
    
    public func getSchool(schooldbn: School, complition: @escaping(Result<[SchoolDetail], NetworkError>) -> ()){
        
        let request = getSearchURL(dbn: schooldbn.dbn!)
        guard let request = request else {
            DispatchQueue.main.async {
                complition(.failure(.badURL))
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode,
                    error == nil else {
                    DispatchQueue.main.async {
                        debugPrint("WebServiceSchool \(error.debugDescription)")
                        complition(.failure(.requestFailed))
                    }
                    return
                }
                
                let decodedResponse = try JSONDecoder().decode([SchoolDetail].self, from: data)
                
                DispatchQueue.main.async {
                    complition(.success(decodedResponse))
                }
                   

            } catch {
                debugPrint("Creation failed with error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    complition(.failure(.error))
                }
            }
        }.resume()
    }
    
    
}

private struct Domain {
    static let scheme = "https"
    static let host = "data.cityofnewyork.us"
    static let path = "/resource/s3k6-pzi2.json"
    static let pathdbn = "/resource/f9bf-2cp4.json"
}
