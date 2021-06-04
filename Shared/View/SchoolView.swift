//
//  SchoolView.swift
//  20210526-BornaLibertines-NYCSchools (iOS)
//
//  Created by Borna Libertines on 5/26/21.
//

import SwiftUI

struct SchoolView: View {
    @State var school: School

    private var address: String {
        let ar = school.location!.components(separatedBy: "(")
        return ar[0]
    }
   
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 8) {
                Text(String(school.schoolname!)).font(.callout).foregroundColor(.primary)
            }
            VStack(alignment: .center, spacing: 8) {
                Text(String(address)).font(.caption2).foregroundColor(.secondary)
            }
        }
    }
}
