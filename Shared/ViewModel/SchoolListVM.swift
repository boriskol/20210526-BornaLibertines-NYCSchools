//
//  SchoolListVM.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import Foundation
import Combine


final class SchoolViewModel: ObservableObject {
    
    init(){
        getSchools()
    }

    @Published var schoolsList = [School]()
    @Published var schoolResult = [SchoolDetail]()
    @Published var school: School?
    @Published var errorSchools: NetworkError?
    
    func getSchools(){
        WebServiceSchool().parseListSchools(complition: { result in
            switch result {
            case .success(let succs):
                self.schoolsList = succs
            case .failure(let err):
                debugPrint("ShoolViewModel \(err.localizedDescription)")
                self.errorSchools = err
            }
        })
    }
    
    func getSchool(schooldbn: School){
        school = schooldbn
        WebServiceSchool().getSchool(schooldbn: schooldbn, complition: { result in
            switch result {
            case .success(let succs):
                self.schoolResult = succs
            case .failure(let err):
                debugPrint("ShoolViewModel \(err.localizedDescription)")
                self.errorSchools = err
            }
        })
    }
    
}
