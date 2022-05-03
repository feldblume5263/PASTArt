//
//  CookingGuideView.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/01.
//

import SwiftUI

struct CookingGuideView: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        VStack {
            Text("\(store.state.config.numberOfPeople ?? 0)명")
            Text("\((store.state.config.typeOfNoodle ?? .spaghetti).rawValue)")
            Text("\((store.state.config.cookingLevel ?? .aldente).rawValue)")
        }
    }
}

//struct CookingGuideView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        CookingGuideView()
//    }
//}
