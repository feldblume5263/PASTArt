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

struct PreconfigurationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        PreconfigurationView()
            .environmentObject(store)
    }
}
