//
//  CookingAmountConfigButtonsView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/01.
//

import SwiftUI

struct CookingAmountConfigButtonsView: View {
    let geometry: GeometryProxy
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            HStack {
                Text("몇 인분을 요리하실 건가요?").foregroundColor(.gray)
                Spacer()
            }.padding(.bottom)
            HStack {
                ForEach(0 ..< store.state.amountButtonState.count, id: \.self) { buttonIdx in
                    let isPressed: Bool = store.state.amountButtonState[buttonIdx]
                    
                    Button { store.dispatch(.amountButtonPressed(buttonIdx)) } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(isPressed ? .black : .clear)
                            
                            Text("\(buttonIdx + 1)").foregroundColor(isPressed ? .white : .gray)
                        }
                    }
                    .aspectRatio(CGSize(width: 1.6, height: 1), contentMode: .fit)
                    .frame(width: geometry.size.width * 0.15) 
                }
                Spacer()
            }
        }
        .padding()
    }
}

struct CookingAmountConfigButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        GeometryReader { geometry in
            CookingAmountConfigButtonsView(geometry: geometry)
                .environmentObject(store)
        }
    }
}
