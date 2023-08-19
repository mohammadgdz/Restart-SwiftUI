//
//  HomeView.swift
//  Restart
//
//  Created by Mohammad on 2023-08-19.
//

import SwiftUI

struct HomeView: View {
    //MARK: - Property
    @AppStorage("onboarding") var isOnboardingActive = true
    @State private var isAnimating = false
    
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - Header
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(
                Animation
                .easeInOut(duration: 4)
                .repeatForever()
                , value: isAnimating
               )
           
            }
            
            //MARK: - Center
            
            Text("The time that leads to mastery is dependent on the intesity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
                
            
            
            //MARK: - Footer
            Spacer()
            Button {
                withAnimation {
                    isOnboardingActive = true
                }
            } label: {
                
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }//: Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)

        }//: VStack
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isAnimating = true
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
