//
//  CircleGroupView.swift
//  Yomu
//
//  Created by Dixon A on 13/10/23.
//

import SwiftUI

struct CircleGroupView: View {
    
    //MARK: - Property
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State private var isAnimating: Bool = false
    
    //MARK: - Body
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }//: ZStack
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}


struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGroupView(ShapeColor: Color(UIColor(.brown)), ShapeOpacity: 0.4)
    }
}

