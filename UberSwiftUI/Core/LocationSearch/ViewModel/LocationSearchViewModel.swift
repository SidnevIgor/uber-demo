import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    
    
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch, completion:  { response, error in
            if let error = error {
                print("Could not get the coordinates \(error)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        })
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping(MKLocalSearch.CompletionHandler)) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destCoordinate = selectedLocationCoordinate else {return 0.0}
        guard let userCoordinate = self.userLocation else {return 0.0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        let tripDistance = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistance)
    }
    
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
