//
//  AuthenticationView-ViewModel.swift
//  Bucket List
//
//  Created by Vito Borghi on 21/11/2023.
//

import LocalAuthentication
import Foundation

extension AuthenticationView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var isUnlocked = false
        @Published var AuthNotAvailable = false
        @Published var showAuthErrorAlert = false
        @Published var AuthErrorTitle: String? = nil
        @Published var authErrorMessage: String? = nil
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // if possible, this runs
                self.AuthNotAvailable = false
                let reason = "You need to unlock your app to continue."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                                self.isUnlocked = true
                        }
                    } else {
                        //auth failed
                        self.AuthErrorTitle = "Authentication Error"
                        self.showAuthErrorAlert = true
                        self.authErrorMessage = authenticationError?.localizedDescription
                    }
                }
            } else {
                //Auth unavailable
                self.AuthErrorTitle = "Biometrics not available"
                self.showAuthErrorAlert = true
                self.authErrorMessage = error?.localizedDescription
                self.AuthNotAvailable = true
                
            }
        }
        
    }
}
