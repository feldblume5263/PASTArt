//
//  CookingGuideCarousel.swift
//  PASTArt
//
//  Created by Noah Park on 2022/05/03.
//

import SwiftUI

struct CookingGuideCarousel: View {
    @EnvironmentObject var store: AppStore
    var typeOfPasta: Pasta
    let geometry: GeometryProxy
    let spacing: CGFloat = 15
    var widthOfHiddenCards: CGFloat { geometry.size.width * 0.035 }
    var cardHeight: CGFloat { geometry.size.height * 0.7 }
    
    var RecipeCards: [RecipeCard] {
        RecipeCard.getRecipesOfPasta(pasta: typeOfPasta)
    }
    
    var body: some View {
        Carousel(numberOfItems: CGFloat(RecipeCards.count), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards) {
            ForEach(RecipeCards, id: \.self.id) { step in
                CookingGuideCard(step: step, geometry: geometry, isFinalCard: step.id == RecipeCards.count - 1 ? true : false)
                    .frame(width: UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2),
                           height: step.id == store.state.activeCard ? cardHeight : cardHeight - 60,
                           alignment: .center)
                    .transition(AnyTransition.slide)
                    .animation(.spring(), value: store.state.activeCard)
            }   
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct Carousel<Items: View>: View {
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var store: AppStore
    
    init(numberOfItems: CGFloat, spacing: CGFloat, widthOfHiddenCards: CGFloat, @ViewBuilder _ items: () -> Items) {
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
    }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(store.state.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(store.state.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) { calcOffset = Float(activeOffset) + store.state.screenDrag }
        
        return HStack(alignment: .center, spacing: spacing) { items }
            .offset(x: CGFloat(calcOffset), y: 0)
            .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
                self.store.dispatch(.updateScreenDrag(Float(currentState.translation.width)))
            }.onEnded { value in
                self.store.dispatch(.updateScreenDrag(0))
                
                if (value.translation.width < -50) {
                    store.dispatch(.turnPageForward)
                    if self.store.state.activeCard <= Int(numberOfItems) - 1 {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    } else { // 왼쪽으로 드래그한 값이 50이 안될 때
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            store.dispatch(.turnPageBackward)
                        }
                    }
                }
                
                if (value.translation.width > 50) {
                    store.dispatch(.turnPageBackward)
                    if self.store.state.activeCard >= 0 {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    } else { // 오른쪽으로 드래그한 값이 50이 안될 때
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            store.dispatch(.turnPageForward)
                        }
                    }
                    
                }
            })
    }
}


struct CookingGuideCards_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let store = AppStore(initialState: .init(), reducer: appReducer)
            CookingGuideCarousel(typeOfPasta: .pomodoro, geometry: geometry)
                .environmentObject(store)
        }
    }
}
