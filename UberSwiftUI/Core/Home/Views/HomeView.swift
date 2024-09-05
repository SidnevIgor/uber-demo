import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authModel: AuthViewModel
    
    var body: some View {
        Group {
            if authModel.userSession == nil {
                LoginView()
            } else if let user = authModel.currentUser {
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                        
                    }.onAppear {
                        showSideMenu = false
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top, content:
                {
                    UberMapViewRepresentable(mapState: $mapState).ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                        .padding(.leading)
                        .padding(.top, 4)
                }
            )
            if mapState == .locationSelected || mapState == .polylineAdded {
                RideRequestView().transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            if let location = location {
                print("Received location \(location)")
                viewModel.userLocation = location
            }
        })
    }
}

#Preview {
    HomeView().environmentObject(LocationSearchViewModel()).environmentObject(AuthViewModel())
}
