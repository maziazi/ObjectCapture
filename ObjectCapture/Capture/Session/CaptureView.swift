//
//  CaptureView.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//

import SwiftUI
#if !targetEnvironment(simulator)
import RealityKit
#endif

public struct CaptureView: View {
    @StateObject private var captureModel = CaptureDataModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showingPointCloud = false
    
    public var body: some View {
        NavigationStack {
            ZStack {
                // Main capture view
                #if targetEnvironment(simulator)
                simulatorView
                #else
                if let session = captureModel.session {
                    if showingPointCloud {
                        ObjectCapturePointCloudView(session: session)
                            .ignoresSafeArea()
                    } else {
                        ObjectCaptureView(session: session)
                            .ignoresSafeArea()
                    }
                } else {
                    loadingView
                }
                #endif
                
                // Overlay UI based on state
                overlayContent
            }
            .background(.black)
            .navigationBarHidden(true)
            .onAppear {
                captureModel.startNewSession()
            }
            .alert("Error", isPresented: .constant(captureModel.error != nil)) {
                Button("OK") {
                    captureModel.error = nil
                    dismiss()
                }
            } message: {
                Text(captureModel.error?.localizedDescription ?? "")
            }
        }
    }
    
    // Simulator placeholder view
    #if targetEnvironment(simulator)
    private var simulatorView: some View {
        VStack {
            Image(systemName: "camera.viewfinder")
                .font(.system(size: 100))
                .foregroundStyle(.white.opacity(0.3))
            
            Text("Object Capture")
                .font(.title)
                .foregroundStyle(.white)
            
            Text("Simulator Mode")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    #endif
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .tint(.white)
            Text("Initializing camera...")
                .foregroundStyle(.white)
        }
    }
    
    @ViewBuilder
    private var overlayContent: some View {
        switch captureModel.state {
        case .ready:
            loadingOverlay
            
        case .start:
            StartingOverlayView(
                continueAction: {
                    captureModel.startDetecting()
                },
                galleryAction: {
                    captureModel.showingGallery = true
                },
                helpAction: {
                    captureModel.showingHelp = true
                }
            )
            
        case .detecting:
            DetectingOverlayView(
                startCaptureAction: {
                    captureModel.startCapturing()
                },
                galleryAction: {
                    captureModel.showingGallery = true
                },
                helpAction: {
                    captureModel.showingHelp = true
                },
                cancelAction: {
                    captureModel.restartSession()
                    dismiss()
                }
            )
            
        case .capturing:
            CapturingOverlayView(
                showingPointCloud: $showingPointCloud,
                scanPassCount: captureModel.scanPassCount,
                cancelAction: {
                    captureModel.restartSession()
                    dismiss()
                }
            )
            
        case .completad:
            FinishedOverlayView(
                topButtonHandler: {
                    await captureModel.beginNewScanPass()
                },
                middleButtonHandler: {
                    await captureModel.beginNewScanPassAfterFlip()
                },
                bottomButtonHandler: {
                    await captureModel.finishCapture()
                    dismiss()
                }
            )
            
        case .finish:
            processingOverlay
            
        case .failed:
            failedOverlay
            
        case .restart:
            EmptyView()
        }
    }
    
    private var loadingOverlay: some View {
        VStack {
            ProgressView()
                .tint(.white)
            Text("Starting session...")
                .foregroundStyle(.white)
        }
    }
    
    private var processingOverlay: some View {
        VStack {
            ProgressView()
                .tint(.white)
            Text("Processing capture...")
                .foregroundStyle(.white)
        }
    }
    
    private var failedOverlay: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            Text("Capture Failed")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .padding(.top)
            
            Button("Try Again") {
                captureModel.restartSession()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .padding(.top)
        }
    }
}
