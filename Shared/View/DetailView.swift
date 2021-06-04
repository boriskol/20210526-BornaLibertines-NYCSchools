//
//  DetailView.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject private var schoolDetail: SchoolViewModel
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8){
            VStack(alignment: .leading, spacing: 8){
                if schoolDetail.schoolTap != nil{
                    SchoolView(school: schoolDetail.schoolTap!)
                }
                Spacer()
                ForEach(schoolDetail.schoolDetail, id: \.id) { school in
                    //
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sat Test Takers : \(String((school.numOfSatTestTakers)!))")
                            .font(.callout).foregroundColor(.primary)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sat Criticaln Reading Avg Score: \(String((school.satCriticalReadingAvgScore)!))")
                            .font(.callout).foregroundColor(.primary)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sat Math Avg Score : \(String((school.satMathAvgScore)!))")
                            .font(.callout).foregroundColor(.primary)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sat Writing Avg Score : \(String((school.satWritingAvgScore)!))")
                            .font(.callout).foregroundColor(.primary)
                    }
                    
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Academic Opportunities: ").font(.callout).foregroundColor(.primary)
                    if schoolDetail.schoolTap?.academicopportunities1 != nil{
                        Text(String((schoolDetail.schoolTap?.academicopportunities1)!))
                            .font(.caption2).foregroundColor(.secondary)
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    if schoolDetail.schoolTap?.academicopportunities2 != nil {
                        Text(String((schoolDetail.schoolTap?.academicopportunities2)!))
                            .font(.caption2).foregroundColor(.secondary)
                    }
                }
            }
            
            
        }.padding()
        
    }
}



/*
 struct DetailView_Previews: PreviewProvider {
 static var previews: some View {
 DetailView()
 }
 }
 */
