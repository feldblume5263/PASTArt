//
//  PreconfigurationView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/04/28.
//

import SwiftUI


struct PreconfigurationView: View {
    @EnvironmentObject var store: AppStore
    @State private var pickerIndex: Int = Int(Noodle.allCases.count / 2)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                CookingAmountConfigButtonsView(geometry: geometry)
                Spacer()
                CookingNoodleConfigPickerView(tempForpicker: $pickerIndex)
                Spacer()
                CookLevelConfigButtonsView(geometry: geometry)
                Spacer()
                StartCookingButton(selectedNoodle: pickerIndex, geometry: geometry)
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
