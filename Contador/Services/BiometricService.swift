//
//  BiometricService.swift
//  Contador
//
//  Created by Diego Herrera on 2026/01/06.
//

import Foundation
import LocalAuthentication
import SwiftUI

@MainActor
class BiometricService{
    var NSerror: NSError?
    
    func checkBiometrics() -> Bool{
        let context = LAContext()
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &NSerror)
    }
    
    func authenticate() async -> Bool {
        let context = LAContext()
        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Used to lock groups under FaceID"
            ) { success, _ in
                continuation.resume(returning: success)
            }
        }
    }
}
