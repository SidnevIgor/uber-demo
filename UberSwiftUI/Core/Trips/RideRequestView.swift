//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by Igor Sidnev on 26/08/2024.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 64, height: 6)
                .padding(.top, 8)
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Current location")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }.padding(.bottom, 10)
                    HStack {
                        Text("Starbucks coffee")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                        Text("1:45 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }.padding(.leading, 8)
            }.padding()
            
            Divider()
            
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(type == selectedRideType ? .white : .black)
                                Text("$22.04")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(type == selectedRideType ? .white : .black)
                            }.padding()
                        }.frame(width: 112, height: 140)
                            .background(Color(type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                            .scaleEffect(type == selectedRideType ? 1.1 : 1.0)
                            .cornerRadius(10)
                            .onTapGesture {
                                withAnimation {
                                    selectedRideType = type
                                }
                            }
                    }
                }
            }.padding(.horizontal)
            
            Divider().padding(.vertical, 8)
            
            HStack(spacing: 10, content: {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                Text("**** 1234")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }).frame(height: 50)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            Button(action: {
                
            }, label: {
                Text("CONFIRM RIDE")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            })
        }
        .padding(.bottom, 24)
        .background(.white)
        .cornerRadius(12)
    }
}

#Preview {
    RideRequestView()
}
