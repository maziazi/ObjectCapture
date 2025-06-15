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
import SwiftUI
#if !targetEnvironment(simulator)
import RealityKit
#endif
import Combine

@MainActor
class CaptureDataModel: ObservableObject {
    @Published var state: CaptureModelState = .ready
    @Published var scanPassCount = 0
    @Published var isReconstructing = false
    @Published var error: Error?
    @Published var showingHelp = false
    @Published var showingGallery = false
    
    // Conditional properties
    #if !targetEnvironment(simulator)
    @Published var session: ObjectCaptureSession?
    @Published var sessionState: ObjectCaptureSession.CaptureState = .initializing
    private var observationTasks: [Task<Void, Never>] = []
    #endif
    
    private var mockSession: CaptureSessionProtocol?
    
    init() {
        setupCaptureDirectories()
        
        #if targetEnvironment(simulator)
        mockSession = MockCaptureSession()
        #endif
    }
    
    deinit {
        #if !targetEnvironment(simulator)
        cancelObservation()
        #endif
    }
    
    // MARK: - Session Management
    func startNewSession() {
        #if targetEnvironment(simulator)
        // Simulator mock
        guard let mockSession = mockSession else {
            self.error = CaptureError.deviceNotSupported
            return
        }
        
        if !mockSession.isSupported {
            self.error = CaptureError.deviceNotSupported
            return
        }
        
        mockSession.start(imagesDirectory: getImagesDirectory(), configuration: "mock")
        state = .start
        
        // Simulate state transitions for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // You can test different states here
        }
        
        #else
        // Real device implementation
        guard ObjectCaptureSession.isSupported else {
            self.error = CaptureError.deviceNotSupported
            return
        }
        
        session = ObjectCaptureSession()
        setupObservation()
        
        var configuration = ObjectCaptureSession.Configuration()
        configuration.checkpointDirectory = getCheckpointDirectory()
        
        session?.start(
            imagesDirectory: getImagesDirectory(),
            configuration: configuration
        )
        
        state = .start
        #endif
    }
    
    func startDetecting() {
        #if targetEnvironment(simulator)
        let success = mockSession?.startDetecting() ?? false
        if success {
            state = .detecting
        } else {
            self.error = CaptureError.sessionFailed
        }
        #else
        let success = session?.startDetecting() ?? false
        if success {
            state = .detecting
        } else {
            self.error = CaptureError.sessionFailed
        }
        #endif
    }
    
    func startCapturing() {
        #if targetEnvironment(simulator)
        mockSession?.startCapturing()
        state = .capturing
        
        // Simulate completion after a few seconds for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.state = .completad
        }
        #else
        session?.startCapturing()
        state = .capturing
        #endif
    }
    
    func finishCapture() {
        #if targetEnvironment(simulator)
        mockSession?.finish()
        state = .finish
        #else
        session?.finish()
        state = .finish
        #endif
    }
    
    func beginNewScanPass() {
        #if targetEnvironment(simulator)
        mockSession?.beginNewScanPass()
        scanPassCount += 1
        #else
        session?.beginNewScanPass()
        scanPassCount += 1
        #endif
    }
    
    func beginNewScanPassAfterFlip() {
        #if targetEnvironment(simulator)
        mockSession?.beginNewScanPassAfterFlip()
        scanPassCount += 1
        state = .start
        #else
        session?.beginNewScanPassAfterFlip()
        scanPassCount += 1
        state = .start
        #endif
    }
    
    func restartSession() {
        #if targetEnvironment(simulator)
        mockSession?.cancel()
        mockSession = MockCaptureSession()
        #else
        session?.cancel()
        session = nil
        cancelObservation()
        #endif
        
        scanPassCount = 0
        state = .ready
        cleanupCaptureDirectories()
    }
    
    // MARK: - Private Methods (Real Device Only)
    #if !targetEnvironment(simulator)
    private func setupObservation() {
        guard let session = session else { return }
        
        observationTasks.append(
            Task {
                for await newState in session.stateUpdates {
                    await MainActor.run {
                        self.sessionState = newState
                        self.handleSessionStateChange(newState)
                    }
                }
            }
        )
        
        observationTasks.append(
            Task {
                for await completed in session.userCompletedScanPassUpdates {
                    if completed {
                        await MainActor.run {
                            self.state = .completad
                        }
                    }
                }
            }
        )
    }
    
    private func cancelObservation() {
        for task in observationTasks {
            task.cancel()
        }
        observationTasks.removeAll()
    }
    
    private func handleSessionStateChange(_ sessionState: ObjectCaptureSession.CaptureState) {
        switch sessionState {
        case .failed(let error):
            self.state = .failed
            self.error = error
        case .completed:
            self.state = .completad
        default:
            break
        }
    }
    #endif
    
    // --File Management--
    private func setupCaptureDirectories() {
        let directories = [getImagesDirectory(), getCheckpointDirectory(), getModelsDirectory()]
                
        for directory in directories {
            try? FileManager.default.createDirectory(
                at: directory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
    
    private func cleanupCaptureDirectories() {
        let directories = [getImagesDirectory(), getCheckpointDirectory()]
                
        for directory in directories {
            try? FileManager.default.removeItem(at: directory)
        }
                
        setupCaptureDirectories()
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func getImagesDirectory() -> URL {
        getDocumentsDirectory().appendingPathComponent("Images")
    }
    
    private func getCheckpointDirectory() -> URL {
        getDocumentsDirectory().appendingPathComponent("Checkpoints")
    }
    
    private func getModelsDirectory() -> URL {
        getDocumentsDirectory().appendingPathComponent("Models")
    }
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
