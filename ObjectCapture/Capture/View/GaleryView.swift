//
//  GaleryView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 14/06/25.
//

import SwiftUI

struct GaleryView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Previous Capture")
                    .font(.title2)
                Text("Your captured models will ")
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .navigationTitle("Gallery")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    GaleryView()
}
