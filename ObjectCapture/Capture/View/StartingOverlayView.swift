//
//  StartingOverlayView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI

struct StartingOverlayView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Move close and center the dot on your object, then tap continue")
                .font(.footnote)
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
                    label:{ Text("Continue").padding(.horizontal, 10)}
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
    StartingOverlayView()
}
