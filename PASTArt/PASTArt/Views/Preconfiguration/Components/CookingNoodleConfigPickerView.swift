//
//  CookingNoodleConfigPickerView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/01.
//

import SwiftUI

struct CookingNoodleConfigPickerView: View {
    @EnvironmentObject var store: AppStore
    let noodleName = ["탈리아텔레", "링귀네", "스파게티니", "스파게티", "부카토니", "파르팔레", "카펠레티"]
    @State private var selectedNoodle = 3
    
    var body: some View {
        VStack {
            HStack {
                Text("어떤 면으로 요리하실 건가요?").foregroundColor(.gray)
                Spacer()
            }
            
            VStack {
                HStack {
                    Picker(selection: $selectedNoodle, label: Text("Please choose a color")) {
                        ForEach(0 ..< noodleName.count, id: \.self) {
                            Text(self.noodleName[$0])
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
