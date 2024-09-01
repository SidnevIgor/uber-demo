//
//  SideMenuView.swift
//  UberSwiftUI
//
//  Created by Igor Sidnev on 01/09/2024.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(spacing: 40) {
            // header view
            VStack(alignment: .leading, spacing: 32) {
                
                // user info
                HStack {
                    Image("male-profile-photo")
                        .resizable()
                        .scaledToFill()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: 64, height: 64)
                    VStack(alignment: .leading,spacing: 8 ) {
                        Text("Stephan Dowless")
                            .font(.system(size: 16, weight: .semibold))
                        Text("test@gmail.com")
                            .font(.system(size: 14))
                            .accentColor(.black)
                            .opacity(0.77)
                    }
                }
                // become a driver
                VStack(alignment: .leading, spacing: 16) {
                    Text("Do more with your account")
                        .font(.footnote)
                    .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.title2)
                            .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        Text("Make Money Driving")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(6)
                    }
                }
                Rectangle().frame(width: 296, height: 0.75)
                    .opacity(0.7)
                    .foregroundColor(Color(.separator))
                    .shadow(color: .black.opacity(0.7), radius: 4)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            VStack {
                ForEach(SideMenuOptionViewModel.allCases) { viewModel in
                    SideMenuOptionView(viewModel: viewModel)
                        .padding()
                }
            }
            Spacer()
            
            
        }
        .padding(.top, 32)
    }
}

#Preview {
    SideMenuView()
}
