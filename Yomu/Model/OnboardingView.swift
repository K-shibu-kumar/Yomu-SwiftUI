//
//  OnboardingView.swift
//  Yomu
//
//  Created by Dixon A on 12/10/23.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Yomu."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    

    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color("ColorGreen")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
    //MARK: - Header
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                        Share your thoughts with the world.
                        """)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15)
                }//: Header
                .opacity(isAnimating ? 1 : 0) //Ternary
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: - Center
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.85), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y:0)
                        .rotationEffect(Angle(degrees: Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Yomu."
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Read."
                                    }
                                }
                        )//: Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//: Center
                .overlay(
                   Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                    .offset(y: 20)
                    , alignment: .bottom
                )
                Spacer()
                
                //MARK: - Footer
                ZStack{
                    // Parts of the footer
                    // 1.Background (Static)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2.Call to action (Static)
                    
                    Text("Swipe to begin...")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    
                    
                    
                    // 3.Capsule(Dynamic width)
                    HStack{
                        Capsule()
                            .fill(Color("ColorYellow"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                        
                    }
                    
                    // 4.Circle(Draggable)
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorYellow"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            buttonOffset = 0
                                            hapticFeedback.notificationOccurred(.warning)
                                            
                                        
                                        }
                                    }
                                }
                        )//Gesture
                        
                        Spacer()
                    }//: HStack
                }//: Footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VStack
        } //: ZStack
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
