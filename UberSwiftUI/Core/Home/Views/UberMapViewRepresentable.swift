import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .locationSelected:
            break
        case .searchingForLocation:
            if let coordinate = viewModel.selectedLocationCoordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let over = MKPolylineRenderer(overlay: overlay)
            over.strokeColor = .systemBlue
            over.lineWidth = 6
            return over
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            
            self.parent.mapView.showAnnotations(self.parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                print("route is here \(route)")
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            
            let userMapItem = MKMapItem(placemark: userPlacemark)
            let destMapItem = MKMapItem(placemark: destPlacemark)
            
            let request = MKDirections.Request()
            request.source = userMapItem
            request.destination = destMapItem
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error = error {
                    print("Failed to calculate directions")
                    return
                }
                
                guard let routes = response?.routes.first else { return }
                completion(routes)
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation() {
            self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
            self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                self.parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
