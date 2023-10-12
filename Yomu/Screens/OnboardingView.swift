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
    
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color("ColorGreen")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                //MARK: - Header
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Read.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                    
                    Text("""
                        Share your thoughts with the world.
                        """)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15)
                }//: Header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: - Center
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                    
                }//: Center
                
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
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                }
                            
                        )//MARK: - Gesture
                        
                        Spacer()
                    }//: HStack
                }//: Footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
            }//: VStack
        } //: ZStack
        .onAppear(perform: {
                isAnimating = true
        })
    }
}

#Preview {
    OnboardingView()
}
