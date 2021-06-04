//
//  ContentView.swift
//  Shared
//
//  Created by Borna Libertines on 5/26/21.
//

/*****************
 
 Using MVVM Arch. in app
 
 if i use UIKIT - will show list of schools in collection view, registered cell, cell on tap load school viewcontroller
 // MARK: - UIKIT
 
 *////////////////////////////////

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SchoolViewModel()
    @State private var isTap = false
    
    var body: some View {
        NavigationView{
            // MARK: - List Schools
                ScrollView(.vertical, showsIndicators: false, content: {
                    ForEach(viewModel.schools, id: \.id) { school in
                        SchoolView(school: school)
                            .onTapGesture {
                                viewModel.getSchool(school: school)
                                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                    self.isTap.toggle()
                                })
                            }
                    }
                }).sheet(isPresented: $isTap) {
                    DetailView()
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("NYC High Schools").font(.headline)
                            Text("DOE Directory").font(.subheadline)
                        }
                    }
                }
        }.onAppear{
            viewModel.getAllSchools()
        }
        .environmentObject(viewModel)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
