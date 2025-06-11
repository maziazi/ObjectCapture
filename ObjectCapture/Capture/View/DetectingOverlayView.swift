//
//  DetectingOverlayView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI

public struct DetectingOverlayView: View {
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
            Text("Move around to ensure that the whole object is inside the box. Drag handles to manually resize.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            HStack{
                Button(
                    action:{},
                    label:{ Image(systemName: "folder")}
                )
                .buttonStyle(PlainButtonStyle())
                .padding(.leading, 60)
                Spacer()
                Button(
                    action:{},
                    label:{ Text("Start Capture").padding(.horizontal, 10)}
                )
                .buttonStyle(BorderedProminentButtonStyle())
                .cornerRadius(100)
                Spacer()
                Button(
                    action:{},
                    label:{ Image(systemName: "questionmark.circle")}
                )
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 60)
            }
            .padding(.bottom, 15)
        }
    }
}

#Preview {
    DetectingOverlayView()
}
