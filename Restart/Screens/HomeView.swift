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
    
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
            
            Button {
                isOnboardingActive = true
            } label: {
                Text("Restart")
            }
        }
        
    }//: VStack
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
