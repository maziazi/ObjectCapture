//
//  CapturingOverlayView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI

public struct CapturingOverlayView: View {
    @Binding var showingPointCloud: Bool
    let scanPassCount: Int
    let cancelAction: () -> Void
    
    public var body: some View {
        VStack {
            // Top UI
            HStack {
                Button(action: cancelAction) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .background(.white, in: Circle())
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Scan pass indicator
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Pass \(scanPassCount + 1) of 3")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                    
                    ProgressView(value: Double(scanPassCount + 1), total: 3)
                        .tint(.blue)
                        .frame(width: 80)
                        .background(.white, in: Capsule())
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.black.opacity(0.6))
                .cornerRadius(12)
            }
            .padding()
            
            Spacer()
            
            // Point cloud toggle
            VStack(spacing: 16) {
                Button(action: {
                    showingPointCloud.toggle()
                }) {
                    HStack {
                        Image(systemName: showingPointCloud ? "camera.fill" : "cube.fill")
                        Text(showingPointCloud ? "Camera View" : "Point Cloud")
                    }
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.black.opacity(0.6))
                    .cornerRadius(20)
                }
                
                // Capture instructions
                Text("Move around the object slowly to capture all angles")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 8)
                    .background(.black.opacity(0.6))
                    .cornerRadius(8)
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    CapturingOverlayView(
        showingPointCloud: .constant(false),
        scanPassCount: 0,
        cancelAction: {}
    )
    .background(.black)
}
