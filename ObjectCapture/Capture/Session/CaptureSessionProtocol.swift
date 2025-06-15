//
//  CaptureSessionProtocol.swift
//  ObjectCapture
//
//  Created by Muhamad Azis on 15/06/25.
//

import Foundation
import RealityKit

// Protocol untuk abstraksi ObjectCaptureSession
protocol CaptureSessionProtocol {
    var isSupported: Bool { get }
    func start(imagesDirectory: URL, configuration: Any)
    func startDetecting() -> Bool
    func startCapturing()
    func finish()
    func cancel()
    func beginNewScanPass()
    func beginNewScanPassAfterFlip()
}

// Real implementation untuk device
#if !targetEnvironment(simulator)
@available(iOS 17.0, *)
class RealCaptureSession: CaptureSessionProtocol {
    private let session = ObjectCaptureSession()
    
    var isSupported: Bool {
        ObjectCaptureSession.isSupported
    }
    
    func start(imagesDirectory: URL, configuration: Any) {
        if let config = configuration as? ObjectCaptureSession.Configuration {
            session.start(imagesDirectory: imagesDirectory, configuration: config)
        }
    }
    
    func startDetecting() -> Bool {
        return session.startDetecting()
    }
    
    func startCapturing() {
        session.startCapturing()
    }
    
    func finish() {
        session.finish()
    }
    
    func cancel() {
        session.cancel()
    }
    
    func beginNewScanPass() {
        session.beginNewScanPass()
    }
    
    func beginNewScanPassAfterFlip() {
        session.beginNewScanPassAfterFlip()
    }
}
#endif

// Mock implementation untuk simulator
class MockCaptureSession: CaptureSessionProtocol {
    var isSupported: Bool = false
    
    func start(imagesDirectory: URL, configuration: Any) {
        print("Mock: Starting capture session")
    }
    
    func startDetecting() -> Bool {
        print("Mock: Start detecting")
        return true
    }
    
    func startCapturing() {
        print("Mock: Start capturing")
    }
    
    func finish() {
        print("Mock: Finish capture")
    }
    
    func cancel() {
        print("Mock: Cancel capture")
    }
    
    func beginNewScanPass() {
        print("Mock: Begin new scan pass")
    }
    
    func beginNewScanPassAfterFlip() {
        print("Mock: Begin new scan pass after flip")
    }
}
