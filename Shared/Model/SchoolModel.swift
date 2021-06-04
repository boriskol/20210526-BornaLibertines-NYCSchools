//
//  SchoolModel.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import Foundation
/*
struct School: Identifiable {
    var id = UUID()
    let dbn: String?
    let schoolname: String?
    let overviewparagraph: String?
    let academicopportunities1: String?
    let academicopportunities2: String?
    let location: String?
    let website: String?
    let primaryaddressline: String?
    let city: String?
    let zip: String?
    let numOfSatTestTakers: String?
    let satCriticalReadingAvgScore: String?
    let satMathAvgScore: String?
    let satWritingAvgScore: String?
}
extension School: Codable {
    enum CodingKeys: String, CodingKey {
        case schoolname = "school_name"
        case overviewparagraph = "overview_paragraph"
        case primaryaddressline = "primary_address_line_1"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
        case dbn, academicopportunities1, academicopportunities2, location, website, city, zip
    }
}
*/

struct School: Codable {
    var id = UUID()
    let dbn: String?
    let schoolname: String?
    let overviewparagraph: String?
    let academicopportunities1: String?
    let academicopportunities2: String?
    let location: String?
    let website: String?
    let primaryaddressline: String?
    let city: String?
    let zip: String?
    
    enum CodingKeys: String, CodingKey {
        case schoolname = "school_name"
        case overviewparagraph = "overview_paragraph"
        case primaryaddressline = "primary_address_line_1"
        case dbn, academicopportunities1, academicopportunities2, location, website, city, zip
    }
    
}


struct SchoolDetail: Codable {
    var id = UUID()
    let dbn: String?
    let schoolName: String?
    let numOfSatTestTakers: String?
    let satCriticalReadingAvgScore: String?
    let satMathAvgScore: String?
    let satWritingAvgScore: String?
    
    
    enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
        case dbn
    }
}
