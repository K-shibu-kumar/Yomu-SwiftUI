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
    }
}

#Preview {
    ZStack {
        Color("ColorGreen")
            .edgesIgnoringSafeArea(.all)
        
        CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
    }
}
