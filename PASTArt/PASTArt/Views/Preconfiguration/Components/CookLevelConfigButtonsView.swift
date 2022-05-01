//
//  CookLevelConfigButtonsView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/01.
//

import SwiftUI

struct CookLevelConfigButtonsView: View {
    let cookLevel = CookLevel.allCases
    let geometry: GeometryProxy
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            HStack {
                Text("원하시는 면 익힘 정도를 골라주세요").foregroundColor(.gray)
                Spacer()
            }
            HStack {
                ForEach(0 ..< store.state.cookLevelButtonState.count, id: \.self) { buttonIdx in
                    let isPressed: Bool = store.state.cookLevelButtonState[buttonIdx]
                    
                    Button { store.dispatch(.cookLevelButtonPressed(buttonIdx)) } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(isPressed ? .black : .clear)
                            
                            Text("\(cookLevel[buttonIdx].rawValue)").foregroundColor(isPressed ? .white : .gray)
                        }
                    }
                    .aspectRatio(CGSize(width: 3.5, height: 1), contentMode: .fit)
                }
                Spacer()
            }
        }
        .padding()
    }
}


struct CookLevelConfigButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        GeometryReader { geometry in
            CookLevelConfigButtonsView(geometry: geometry)
                .environmentObject(store)
        }
    }
}
