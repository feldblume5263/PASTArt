//
//  PreconfigurationView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/28.
//

import SwiftUI

struct PreconfigurationView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                CookingAmountConfigButtonsView(geometry: geometry)
                Spacer()
                CookingNoodleConfigPickerView()
                Spacer()
                CookLevelConfigButtonsView(geometry: geometry)
                Spacer()
                StartCookingButton(geometry: geometry)
            }
        }
    }
}

struct StartCookingButton: View {
    @EnvironmentObject var store: AppStore
    let geometry: GeometryProxy
    
    var body: some View {
        Button { store.dispatch(.goToCookingStage) } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                
                Text("시작하기").foregroundColor(.white)
            }
        }
        .aspectRatio(CGSize(width: 4, height: 1), contentMode: .fit)
        .frame(width: geometry.size.width * 0.5)
        
    }
}

struct PreconfigurationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        
        PreconfigurationView()
            .environmentObject(store)
    }
}
