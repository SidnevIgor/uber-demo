import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
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
                MapViewActionButton(mapState: $mapState)
                        .padding(.leading)
                        .padding(.top, 4)
                }
            )
            if mapState == .locationSelected {
                RideRequestView().transition(.move(edge: .bottom))
            }
        }.edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation, perform: { location in
                if let location = location {
                    print("Received location \(location)")
                    viewModel.userLocation = location
                }
            })
    }
}

#Preview {
    HomeView().environmentObject(LocationSearchViewModel())
}
