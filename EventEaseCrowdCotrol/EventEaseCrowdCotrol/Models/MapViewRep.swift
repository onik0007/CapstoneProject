//
//  MapViewRep.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapViewRep: UIViewRepresentable {
    typealias UIViewType = MKMapView
    var party: Party

    @StateObject private var locationManager = LocationManager()
    var destination: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator

        // Request location permissions
        locationManager.requestAuthorization()

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the destination annotation
        uiView.removeAnnotations(uiView.annotations)
        let destinationPin = MKPointAnnotation()
        destinationPin.title = party.title
        destinationPin.coordinate = destination
        uiView.addAnnotation(destinationPin)
        
        // Calculate and display the route
        guard let userLocation = locationManager.userLocation else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            uiView.addOverlay(route.polyline)
            uiView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
        }
    }

    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        private let parent: MapViewRep

        init(_ parent: MapViewRep) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
    
    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager = CLLocationManager()

        @Published var userLocation: CLLocation?

        override init() {
            super.init()
            locationManager.delegate = self
        }

        func requestAuthorization() {
            locationManager.requestWhenInUseAuthorization()
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let userLocation = locations.last else { return }
            self.userLocation = userLocation
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location manager error: \(error.localizedDescription)")
        }
    }

}
