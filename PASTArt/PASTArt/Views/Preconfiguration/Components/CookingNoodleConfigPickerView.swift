//
//  CookingNoodleConfigPickerView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/01.
//

import SwiftUI

struct CookingNoodleConfigPickerView: View {
    @EnvironmentObject var store: AppStore
    let noodleName = Noodle.allCases
    
    var body: some View {
        VStack {
            HStack {
                Text("어떤 면으로 요리하실 건가요?").foregroundColor(.gray)
                Spacer()
            }
            VStack {
                HStack {
                    Picker(selection: $store.state.selectedNoodle, label: Text("Please choose a color")) {
                        ForEach(0 ..< noodleName.count, id: \.self) {
                            Text(self.noodleName[$0].rawValue)
                        }
                    }.pickerStyle(.wheel)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct CookingNoodleConfigPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AppStore(initialState: .init(), reducer: appReducer)
        
        CookingNoodleConfigPickerView()
            .environmentObject(store)
    }
}
