//
//  CircleGroupView.swift
//  Restart
//
//  Created by Mohammad on 2023-08-19.
//

import SwiftUI

struct CircleGroupView: View {
    
    //MARK: - Property
    
    @State var ShapeColor : Color
    @State var ShapeOpacity : Double
    
    //MARK: - Body
    var body: some View {
        ZStack{
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }//: ZStack
    }
}


//MARK: - Preview
struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
