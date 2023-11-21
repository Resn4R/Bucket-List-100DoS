//
//  AuthenticationView.swift
//  Bucket List
//
//  Created by Vito Borghi on 08/11/2023.
//
import SwiftUI

struct AuthenticationView: View {
    @Environment (\.dismiss) var quitApp
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack{
            Text("Bukkit")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.black)
                .fontDesign(.serif)
            if viewModel.isUnlocked {
                Main_Menu()
            }
            if viewModel.AuthNotAvailable{
                Button("Unlock"){
                    viewModel.authenticate()
                }
                .padding()
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .foregroundStyle(.white)
            }
        }
        .onAppear { viewModel.authenticate() }
        
        .alert(viewModel.AuthErrorTitle ?? "Error", isPresented: $viewModel.showAuthErrorAlert) {
            Button("OK") {
                viewModel.showAuthErrorAlert = false
                viewModel.authenticate()
            }
        } message: {
            Text(viewModel.authErrorMessage ?? "An error has occurred during authentication, please try again.")
        }

        
    }
    

    
}

#Preview {
    AuthenticationView()
}
