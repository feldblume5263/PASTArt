//
//  StartCookingButton.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/02.
//

import SwiftUI

struct StartCookingButton: View {
    @EnvironmentObject var store: AppStore
    let selectedNoodle: Int
    let geometry: GeometryProxy
    
    var body: some View {
        Button {
            store.dispatch(.setNumberOfPeople((store.state.amountButtonState.firstIndex(of: true) ?? 0) + 1))
            store.dispatch(.setConfigs(
                (store.state.amountButtonState.firstIndex(of: true) ?? 0) + 1,
                selectedNoodle,
                store.state.cookLevelButtonState.firstIndex(of: true) ?? 0))
            store.dispatch(.goToCookingStage)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                
                Text("시작하기").foregroundColor(.white)
            }
        }
        .aspectRatio(CGSize(width: 4, height: 1), contentMode: .fit)
        .frame(width: geometry.size.width * 0.5)
        .padding()
        
    }
}

struct StartCookingButton_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            StartCookingButton(selectedNoodle: 3, geometry: geometry)
        }
    }
}
