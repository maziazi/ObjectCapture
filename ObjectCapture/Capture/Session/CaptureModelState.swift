//
//  CaptureModelState.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 12/06/25.
//
//enum CaptureModelState {
//    case ready
//    case start
//    case detecting
//    case capturing
//    case finish
//    case completad
//    case restart
//    case failed
//}

import Foundation
import RealityKit
import Combine

@MainActor
class CaptureModelState: ObservableObject {
    @Published var session: ObjectCaptureSession?
    @Published var state: CaptureModelState = .ready
    @Published var sessionState: ObjectCaptureSession.State = .initializing
    @Published var scanPassCount = 0
    @Published var isReconstructing = false
    @Published var error: Error?
    @Published var showingHelp = false
    @Published var showingGallery = false
    
    private var cacellables = Set<AnyCancellable>()
    
    init() {
        setupCaptureDirectories()
    }
    
    // --Session Mannagement--
    func startNewSession() {
        
    }
    
    func startDetecting() {
        
    }
    
    func startCapturing() {
        
    }
    
    func finsihCapture() {
        
    }
    
    func beginNewScanPass() {
        
    }
    
    func beginNewScanPassAfterFlip() {
        
    }
    
    func restartSession() {
        
    }
    
    // --Private Methods--
    private func observeSessionState() {
        
    }
    
    private func handlesSessionStateChange(_ sessionState: ObjectCaptureSession.State){
        
    }
    
    // --File Management--
    private func setupCaptureDirectories() {
        
    }
    
    private func cleanupCapturDirectories() {
        
    }
    
    private func getDocumentsDirectory() -> URL {
        
    }
    
    private func getImagesDirectory() -> URL {
        
    }
    
    private func getCheckpointDirectory() -> URL {
        
    }
    
    private func getModelDirectory() -> URL {
        
    }
    
    // --Eror Types--
    enum CaptureError: LocalizedError {
        case deviceNotSupported
        case sessionFailed
        case reconstructionFailed
        
        var errorDescription: String? {
            switch self {
            case .deviceNotSupported:
                return "This device does not support object capture."
            case .sessionFailed:
                return "Failed to create a session."
            case .reconstructionFailed:
                return "Failed to reconstruct the scene."
            }
        }
    }
}
