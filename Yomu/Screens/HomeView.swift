//
//  HomeView.swift
//  Yomu
//
//  Created by Dixon A on 12/10/23.
//

import SwiftUI

struct HomeView: View {
    //MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color("ColorPink")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                //MARK: - Header
                Spacer()
                ZStack {
                    CircleGroupView(ShapeColor: .colorGrey, ShapeOpacity: 0.2)
                    
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .offset(y: isAnimating ? 35 : -35)
                        .animation(Animation.easeOut(duration: 4)
                            .repeatForever(), value: isAnimating
                        )
                }
                
                //MARK: - Center
                Text("Don't write anything you can phone. Don't phone anything you can talk. Don't talk anything you can whisper. Don't whisper anything you can smile. Don't smile anything you can nod. Don't nod anything you can wink.😉")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color.colorGrey)
                    .multilineTextAlignment(.center)
                    .padding()
                
                //MARK: - Footer
                Spacer()
                
                
                Button(action: {// Some action
                    withAnimation{
                        playSound(sound: "success", type: "m4a")
                        isOnboardingViewActive = true
                    }
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    
                    Text("Back to Home")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                    
                }//: Button
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(Color.colorDarkGreen)
            }
        }//: VStack
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAnimating = true
            }
        })
    }
}

#Preview {
    HomeView()
}
