//
//  SideMenuOptionView.swift
//  UberSwiftUI
//
//  Created by Igor Sidnev on 01/09/2024.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel: SideMenuOptionViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.title2)
                .imageScale(.medium)
            Text(viewModel.title)
                .font(.system(size: 16, weight: .semibold))
            Spacer()
        }.foregroundColor(Color.theme.primaryTextColor)
    }
}

#Preview {
    SideMenuOptionView(viewModel: .trips)
}
