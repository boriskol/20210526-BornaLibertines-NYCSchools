//
//  SchoolListVM.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import Foundation
import SwiftUI
import Combine

class SchoolViewModel: ObservableObject {
  let schoolProvider: SchoolsProvider! = SchoolsApi()
  @Published private(set) var schools: [School] = []
  @Published private(set) var schoolDetail: [SchoolDetail] = []
  @Published private(set) var schoolTap: School?
  var publishers = [AnyCancellable]()
    
    init() {
        //getAllSchools()
    }
    
    //MARK: Combine
    
    func getAllSchools(){
        schoolProvider.getAllSchools()
            .map { $0 }
            .sink(
                receiveCompletion: { error in
                print(" \(error)")
                },
                receiveValue: { art in
                    DispatchQueue.main.async { [self] in
                    schools = art
                }
            })
            .store(in: &publishers)
    }
    func getSchool(school: School){
        schoolTap = school
        schoolProvider.getSchool(school: school)
            .map { $0 }
            .sink(
                receiveCompletion: { error in
                debugPrint("no school \(error)")
                },
                receiveValue: { art in
                    DispatchQueue.main.async { [self] in
                       schoolDetail = art
                }
            })
            .store(in: &publishers)
    }

}



