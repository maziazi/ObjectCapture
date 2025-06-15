//
//  DetectingOverlayView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI

public struct DetectingOverlayView: View {
    let startCaptureAction: () -> Void
    let galleryAction: () -> Void
    let helpAction: () -> Void
    let cancelAction: () -> Void
    
    public var body: some View {
        VStack {
            // Cancel button
            HStack {
                Button(action: cancelAction) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .background(.white, in: Circle())
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            // Instructions
            VStack(spacing: 16) {
                Text("Move around to ensure that the whole object is inside the box. Drag handles to manually resize.")
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
                
                Button(action: startCaptureAction) {
                    Text("Start Capture")
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
    DetectingOverlayView(
        startCaptureAction: {},
        galleryAction: {},
        helpAction: {},
        cancelAction: {}
    )
    .background(.black)
}
