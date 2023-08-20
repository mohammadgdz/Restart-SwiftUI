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
    @State private var isAnimating = false
    @State private var imageOffset : CGSize = .zero
    @State private var indicationOpacity = 1.0
    @State private var textTitle = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                //MARK: - Header
                
                Spacer()
                
                VStack {
                    
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)

                    Text("""
It's not how much we give but
how much love we put into giving.
""")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                }//: Header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: - Center
                
                ZStack{
                    ZStack{
                        CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                            .offset(x: imageOffset.width * -1)
                            .blur(radius: abs(imageOffset.width / 5))
                            .animation(.easeOut(duration: 0.8), value: imageOffset)
                    }//:ZStack
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.3 , y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                    
                    //MARK: Image Gesture
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicationOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicationOpacity = 1
                                        textTitle = "Share."
                                    }
                                })
                        )//: Gesture image
                        .animation(.easeOut(duration: 0.8), value: imageOffset)
                    
                }//: Center
                
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .light))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(1), value: isAnimating)
                        .opacity(indicationOpacity)
                    
                    , alignment: .bottom
                )
                
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
                        
                        //MARK: Button Gesture
                        .gesture(
                            DragGesture()
                            
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 , buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                        
                                    }
                                })
                                .onEnded({ _ in
                                    
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        // if the red button is in the right alrea
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                            playSound(sound: "chimeup", type: "mp3")
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                            
                        )//:Gesture
                        
                        Spacer()
                    }//: HStack
                    
                }//: Footer
                .frame(width: buttonWidth ,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//:VStack
        } // : ZStack
        
        .onAppear() {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

//MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
