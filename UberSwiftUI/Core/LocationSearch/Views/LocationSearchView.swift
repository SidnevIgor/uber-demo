import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @Binding var showLocationSearchView: Bool
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    TextField("Where to? ", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
                .padding(.horizontal)
                .padding(.top, 64)
            Divider().padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading, content: {
                    ForEach(viewModel.results, id: \.self, content: { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle).onTapGesture {
                            viewModel.selectLocation(result.title)
                            showLocationSearchView.toggle()
                        }
                    })
                })
            }
        }.background(Color.white)
    }
}

#Preview {
    LocationSearchView(showLocationSearchView: .constant(true)).environmentObject(LocationSearchViewModel())
}
