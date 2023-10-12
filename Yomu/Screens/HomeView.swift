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
    
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - Header
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .brown, ShapeOpacity: 0.2)

                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
            }
            
            //MARK: - Center
            Text("Don't write anything you can phone. Don't phone anything you can talk. Don't talk anything you can whisper. Don't whisper anything you can smile. Don't smile anything you can nod. Don't nod anything you can wink.")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Color.colorPink)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: - Footer
            Spacer()
            
            
            Button(action: {// Some action
                isOnboardingViewActive = true
            }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    
                    Text("Yomu")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                
            }//: Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(Color.colorDarkGreen)
        }//: VStack
    }
}

#Preview {
    HomeView()
}
