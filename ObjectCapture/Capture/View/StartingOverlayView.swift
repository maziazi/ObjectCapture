//
//  StartingOverlayView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI

struct StartingOverlayView: View {
    let continueAction: () -> Void
    let galleryAction: () -> Void
    let helpAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            // Instructions
            VStack(spacing: 16) {
                Text("Move close and center the dot on your object, then tap continue")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(.black.opacity(0.6))
                    .cornerRadius(12)
            }
            
            // Action buttons
            HStack(spacing: 60) {
                Button(action: galleryAction) {
                    Image(systemName: "folder")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(.black.opacity(0.6))
                        .cornerRadius(22)
                }
                
                Button(action: continueAction) {
                    Text("Continue")
                        .font(.headline)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .cornerRadius(25)
                
                Button(action: helpAction) {
                    Image(systemName: "questionmark.circle")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(.black.opacity(0.6))
                        .cornerRadius(22)
                }
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    StartingOverlayView(
        continueAction: {},
        galleryAction: {},
        helpAction: {}
    )
    .background(.black)
}
