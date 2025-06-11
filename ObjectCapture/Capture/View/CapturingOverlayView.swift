//
//  CapturingOverlayView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI

public struct CapturingOverlayView: View {
    public var body: some View {
        VStack{
            Button(
                action:{},
                label:{ Image(systemName:"xmark.circle").foregroundStyle(.red)}
            )
            .buttonStyle(PlainButtonStyle())
            .cornerRadius(10)
            .padding(.trailing, 330)
            Spacer()
        }
    }
}
    
#Preview{
    CapturingOverlayView()
}
