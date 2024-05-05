//
//  ContentView.swift
//  BucketList
//
//  Created by Christoph on 20.04.24.
//
import LocalAuthentication
import SwiftUI


struct FaceID: View {
    
    @State private var isUnlocked = false
    
    // Challenge 2
    @State private var unlockFailed = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: autheticate)
    }
    
    func autheticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, autheticationError in
                if success {
                    isUnlocked = true
                } else {
                    // Challenge 2
                    unlockFailed = true
                }
            }
        } else {
            // no biometrics
        }
    }
    
}

#Preview {
    FaceID()
}

