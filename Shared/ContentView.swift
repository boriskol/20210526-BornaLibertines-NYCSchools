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
 
 lazy var collectionView :UICollectionView = {
     let layout = UICollectionViewFlowLayout()
     layout.sectionHeadersPinToVisibleBounds = true
     let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
     layout.scrollDirection = .horizontal
     collectionV.translatesAutoresizingMaskIntoConstraints = false
     collectionV.backgroundColor = .clear
     
     collectionV.register(SchoolCell.self, forCellWithReuseIdentifier: reuseId)
     
     return collectionV
 }()

 override func viewDidLoad() {
     super.viewDidLoad()

     self.collectionView.dataSource = self
     self.collectionView.delegate = self
     self.collectionView.keyboardDismissMode = .interactive
     
     self.view.addSubview(collectionView)
     
     NSLayoutConstraint.activate([
         self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
         self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
         self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
         self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
     ])
     self.collectionView.reloadData()
 }
 extension ViewControllerCollection: UICollectionViewDataSource {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.dataSearch.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! SchoolCell
             
         return cell
         
     }
 }
 extension ViewControllerCollection: UICollectionViewDelegate {

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
         let post = self.dataSearch[indexPath.item]
         let swiftUIView = VideoViewController(search: post.school)
         let viewCtrl = UIHostingController(rootView: swiftUIView)
         present(viewCtrl, animated: true) {
        
         }
     }
 }
 
 *////////////////////////////////

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var schoolList: SchoolViewModel
    @State private var isTap = false
    var body: some View {
        NavigationView{
            if schoolList.errorSchools != nil{
                Text("Ops Somthing went wrong!!!")
            }else{
                //present VM schoolList with List
                // it can be done with ForEach
                // MARK: - List Schools
                List(self.schoolList.schoolsList, id: \.dbn){ school in
                    VStack(alignment: .leading, spacing: 8) {
                        if isTap {
                            NavigationLink(destination: DetailView(), isActive: self.$isTap) {EmptyView()}
                        }
                        SchoolView(school: school)
                        .onTapGesture {
                            // MARK: - Get School Detail, Navigate to DetailView
                            schoolList.getSchool(schooldbn: school)
                            DispatchQueue.main.async {
                                self.isTap.toggle()
                            }
                        }
                    }
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
