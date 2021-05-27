//
//  DetailView.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import SwiftUI

struct DetailView: View {
    //@State var school: School
    @EnvironmentObject var schoolDetail: SchoolViewModel
    
    var body: some View {
        if schoolDetail.schoolResult.isEmpty{
            Text("No School Results")
        }else{
            VStack(alignment: .leading, spacing: 8){
                VStack{
                    SchoolView(school: schoolDetail.school!)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sat Test Takers : \(String((schoolDetail.schoolResult.first?.numOfSatTestTakers)!))")
                        .font(.callout).foregroundColor(.primary)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sat Criticaln Reading Avg Score: \(String((schoolDetail.schoolResult.first?.satCriticalReadingAvgScore)!))")
                        .font(.callout).foregroundColor(.primary)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sat Math Avg Score : \(String((schoolDetail.schoolResult.first?.satMathAvgScore)!))")
                        .font(.callout).foregroundColor(.primary)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sat Writing Avg Score : \(String((schoolDetail.schoolResult.first?.satWritingAvgScore)!))")
                        .font(.callout).foregroundColor(.primary)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Academic Opportunities: ").font(.callout).foregroundColor(.primary)
                    if schoolDetail.school?.academicopportunities1 != nil{
                        Text(String((schoolDetail.school?.academicopportunities1)!))
                            .font(.caption2).foregroundColor(.secondary)
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    if schoolDetail.school?.academicopportunities2 != nil {
                        Text(String((schoolDetail.school?.academicopportunities2)!))
                            .font(.caption2).foregroundColor(.secondary)
                    }
                }
                Spacer()
            }.padding()
        }
        
    }
}
/*
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
 */
