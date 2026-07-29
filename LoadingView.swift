//
//  LoadingView.swift
//  TargetIT
//
//  Created by JOURNi Student on 7/28/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        Image("logo")
              .resizable()
              .scaledToFit()
              .frame(width: 600, height: 600)
              .padding()
              .background(Color.white)
              .cornerRadius(20)
          Text("Loading...")
              
    }
    //
    
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var pillOffset: CGFloat = 0.8
    // Logo
    
    
    // Animation Timing
    private let logoAnimationDelay: Double = 0.2
    private let textAnimationDelay: Double = 0.4
    private let pillsStartDelay: Double = 1.0
    private let totalDuration: Double = 1.8
    // Animation methood
    private func performAnimation() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7).delay(logoAnimationDelay)) {
            logoScale = 1.0
            logoOpacity = 1.0
            }
        }
    }
    #Preview {
    }
