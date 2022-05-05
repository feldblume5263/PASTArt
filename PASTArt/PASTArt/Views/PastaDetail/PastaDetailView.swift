//
//  PastaDetailView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/06.
//

import SwiftUI

struct PastaDetailView: View {
    let pastaInfo: PastaInfo
    let geometry: GeometryProxy
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ZStack {
                        Image(pastaInfo.picture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(pastaInfo.name).font(.title.bold())
                                HStack {
                                    Image(systemName: "timer")
                                    Text(pastaInfo.time)
                                }.font(.body.bold())
                            }
                            .padding()
                            Spacer()
                        }
                        Button {
                            store.dispatch(.goToConfigStage)
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
                            .padding()
                        }
                        Divider().foregroundColor(.black)
                        VStack(alignment: .leading) {
                            Text("요리 재료 (1인분 기준)").foregroundColor(.gray).font(.body)
                                .padding()
                            ForEach(0 ..< pastaInfo.ingredient.count, id: \.self) { idx in
                                HStack {
                                    Text(pastaInfo.ingredient[idx].name)
                                    Spacer()
                                    Text(String(format: "%.0f", pastaInfo.ingredient[idx].amount))
                                    Text(pastaInfo.ingredient[idx].scale)
                                }.padding()
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
            HStack {
                Spacer()
                VStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 30, height: 30)
                            .opacity(0.8)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}
//struct PastaDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PastaDetailView()
//    }
//}
