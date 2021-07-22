//
//  BiometricAuthManager.swift
//  Notes
//
//  Created by Tobias Ruano on 19/07/2021.
//

import Foundation
import LocalAuthentication

class BiometricAuthManager {
    
    enum BiometricType {
        case none
        case touchID
        case faceID
        case unknown
    }
    
    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancel
        case userFallback
        case biometryNotAvailable
        case biometryNotEnrolled
        case biometryLockout
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .authenticationFailed: return "There was a problem verifying your identity."
            case .userCancel: return "You pressed cancel."
            case .userFallback: return "You pressed password."
            case .biometryNotAvailable: return "Face ID/Touch ID is not available."
            case .biometryNotEnrolled: return "Face ID/Touch ID is not set up."
            case .biometryLockout: return "Face ID/Touch ID is locked."
            case .unknown: return "Face ID/Touch ID may not be configured"
            }
        }
    }
    
    static let shared = BiometricAuthManager()
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    private var error: NSError?
    
    init(policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics, localizedReason: String = "Verify your identity", localizedFallabackTitle: String = "Enter App Password") {
        self.policy = policy
        self.localizedReason = localizedReason
        context.localizedFallbackTitle = localizedFallabackTitle
        context.localizedCancelTitle = "Cancel"
    }
    
    func canEvaluate(completion: (Bool, BiometricType, BiometricError?) -> Void) {
        guard context.canEvaluatePolicy(policy, error: &error) else {
            let type = biometricType(for: context.biometryType)
            guard let error = error else {
                return completion(false, type, nil)
            }
            
            return completion(false, type, biometricError(from: error))
        }
        
        completion(true, biometricType(for: context.biometryType), nil)
    }
    
    func evaluate(completion: @escaping (Bool, BiometricError?) -> Void) {
        // Asks Context to evaluate a Policy with a LocalizedReason
        context.evaluatePolicy(policy, localizedReason: localizedReason) { [weak self] success, error in
            // Moves to the main thread because completion triggers UI changes
            DispatchQueue.main.async {
                if success {
                    // Context successfully evaluated the Policy
                    completion(true, nil)
                } else {
                    // Unwraps Error
                    // If not available, sends false for Success & nil for BiometricError
                    guard let error = error else { return completion(false, nil) }
                    
                    // Maps error to our BiometricError
                    completion(false, self?.biometricError(from: error as NSError))
                }
            }
        }
    }
    
    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return.none
        case .faceID:
            return .faceID
        case .touchID:
            return .touchID
        default:
            return .unknown
        }
    }
    
    private func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.userFallback:
            error = .userFallback
        case LAError.biometryNotAvailable:
            error = .biometryNotAvailable
        case LAError.biometryNotEnrolled:
            error = .biometryNotEnrolled
        case LAError.biometryLockout:
            error = .biometryLockout
        default:
            error = .unknown
        }
        
        return error
    }
}
