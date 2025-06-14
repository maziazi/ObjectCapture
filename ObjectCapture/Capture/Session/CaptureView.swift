//
//  CaptureView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import RealityKit
import SwiftUI

public struct CaptureView: View {
    @StateObject private var captureModel = CaptureDataModel()
    @Environment (\.dismiss) private var dismiss
    @State private var showingPointCloud = false
    
    public var body: some View {
        ZStack {
            if let session = captureModel.session {
                if showingPointCloud {
                    ObjectCapturePointCloudView(session: session)
                        .ignoresSafeArea()
                } else {
                    ObjectCaptureView(session: session)
                        .ignoresSafeArea()
                }
            } else {
                Color.black
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            ProgressView()
                                .tint(.white)
                            Text("Initializing camera...")
                                .foregroundStyle(.white)
                        }
                    )
            }
            overlayContent
        }
        .background(.black)
        .navigationBarHidden(true)
        .onAppear {
            captureModel.startNewSession()
        }
        .alert("Error", isPresented: .constant(captureModel.error != nil)){
            Button("OK") {
                captureModel.errpr = nil
                dismiss()
            }
        } message: {
            Text (captureModel.error?.localizedDescription ?? "")
        }
        .sheet(isPresented: $captureModel.showingHelp){
            HelpView()
        }
        .sheet(isPresented: $captureModel.showingGallery){
            GaleryView()
        }
        .fullScreenCover(isPresented: .constant(captureModel.state==.completed)){
            FinishedOverlayView(
                topButtonHandler:{
                    captureModel.beginNewScanPass()
                },
                middleButtonHandler:{
                    captureModel.beginNewScanPassAfterFlip()
                },
                bottomButtonHandler:{
                    captureModel.finishCapture()
                    dismiss()
                }
            )
        }
    }
}
