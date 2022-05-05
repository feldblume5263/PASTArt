//
//  PastaLibraryView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/06.
//

import SwiftUI

struct PastaLibraryView: View {
    var columns: [GridItem] { [GridItem(.fixed(100))] }
    @EnvironmentObject var store: AppStore
    @State var showCookingModal: Bool = false
    @State var selectedIdx: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(0..<pastaInfos.count, id: \.self) { idx in
                            LibraryCardView(pastaInfo: pastaInfos[idx], geometry: geometry, showCookingModal: $showCookingModal, selectedIdx: $selectedIdx, idx: idx)
                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.6)
                                .onTapGesture {
                                    store.dispatch(.goToDetailStage)
                                    showCookingModal = true
                                    selectedIdx = idx
                                }
                        }
                        .fullScreenCover(isPresented: $showCookingModal) {
                            CookingConfigAndGuideView(pastaInfo: pastaInfos[selectedIdx], typeOfPasta: pastaInfos[selectedIdx].pasta)
                        }
                        
                    }
                    .padding()
                }
                .navigationTitle("Recipes")
            }
        }
    }
}

struct LibraryCardView: View {
    @EnvironmentObject var store: AppStore
    let pastaInfo: PastaInfo
    let geometry: GeometryProxy
    @Binding var showCookingModal: Bool
    @Binding var selectedIdx: Int
    let idx: Int
    
    var body: some View {
        ZStack {
            Image(pastaInfo.picture)
                .resizable()
                .cornerRadius(20)
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
            RoundedRectangle(cornerRadius: 20)
                .opacity(0.5)
            VStack {
                Text(pastaInfo.name).padding(.top, geometry.size.height * 0.15).font(.largeTitle.bold()).foregroundColor(.white)
                HStack {
                    Image(systemName: "timer")
                    Text(pastaInfo.time)
                }
                .padding()
                .font(.title3).foregroundColor(.white)
                Spacer()
                Button {
                    store.dispatch(.goToConfigStage)
                    selectedIdx = idx
                    showCookingModal = true
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                            .opacity(0.8)
                            .aspectRatio(CGSize(width: 4, height: 1), contentMode: .fit)
                            .frame(width: geometry.size.width * 0.45)
                        Text("요리 하기")
                            .foregroundColor(.white).font(.title3.bold())
                        
                    }
                }
                Spacer()
            }
        }
    }
}

struct PastaLibraryView_Previews: PreviewProvider {
    static var previews: some View {
        PastaLibraryView()
    }
}
