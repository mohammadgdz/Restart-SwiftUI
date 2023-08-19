//
//  OnboardingView.swift
//  Restart
//
//  Created by Mohammad on 2023-08-19.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Property
    
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    @State private var buttonWidth = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                //MARK: - Header
                
                Spacer()
                
                VStack {
                    Text("Share")
                    
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
It's not how much we give but
how much love we put into givving.
""")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                }//: Header
                
                //MARK: - Center
                
                ZStack{
                    ZStack{
                        CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    }//:ZStack
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                    
                }//: Center
                
                Spacer()
                
                //MARK: - Footer
                
                ZStack{
                    //Parts of the custom button
                    
                    
                    //1. BACKGROUND (STATIC)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    //2. CALL-TO-ACTION (STATIC)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    //3. CAPSULE (DYNAMIC WIDTH)
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    //4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80 , alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                            
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 , buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                        
                                    }
                                })
                                .onEnded({ _ in
                                    
                                    // if the red button is in the right alrea
                                    if buttonOffset > buttonWidth / 2 {
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    } else {
                                        buttonOffset = 0
                                    }
                                })
                                
                        )//:Gesture
                        
                        Spacer()
                    }//: HStack
                    
                }//: Footer
                .frame(width: buttonWidth ,height: 80, alignment: .center)
                .padding()
            }//:VStack
        } // : ZStack
    }
}

//MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
