//
//  Request.swift
//  20210526-BornaLibertines-NYCSchools
//
//  Created by Borna Libertines on 6/3/21.
//

import Combine

public enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol SchoolsProvider {
    func getAllSchools<T: Codable>() -> AnyPublisher<[T], APIError>
    func getSchool<T: Codable>(school: School) -> AnyPublisher<[T], APIError>
}
