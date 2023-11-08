//
//  AuthenticationView.swift
//  Bucket List
//
//  Created by Vito Borghi on 08/11/2023.
//
import LocalAuthentication
import SwiftUI

struct AuthenticationView: View {
    @Environment (\.dismiss) var quitApp
    @State private var isUnlocked = false
    
    @State private var showUnavailableAuthAlert = false
    @State private var unavailableAuthMessage: String?
    
    @State private var showAuthErrorAlert = false
    @State private var authErrorMessage: String?
    
    var body: some View {
        NavigationStack{
            Text("Bukkit")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.black)
                .fontDesign(.serif)
            if isUnlocked {
                NavigationLink("") {
                    ContentView()
                }
            }

        }
        .onAppear(perform: { authenticate() })
        
        .alert("Biometrics Unavailable", isPresented: $showUnavailableAuthAlert) {
            Button("OK") {
                showUnavailableAuthAlert = false
                authenticate()
            }
        } message: {
                Text(unavailableAuthMessage ?? "FaceID not setup or not authorised. Please enable.")
        }
        
        .alert("Authentication Error", isPresented: $showAuthErrorAlert) {
            Button("OK") { showAuthErrorAlert = false }
        } message: {
            Text(authErrorMessage ?? "Unknown authentication error, try again.")
            
        }
        
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // if possible, this runs
            let reason = "We need to unlock your App."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    //auth failed
                    showAuthErrorAlert = true
                    authErrorMessage = authenticationError?.localizedDescription
                }
            }
        } else {
            showUnavailableAuthAlert = true
            unavailableAuthMessage = error?.localizedDescription
            
        }
    }
    
}

#Preview {
    AuthenticationView()
}
