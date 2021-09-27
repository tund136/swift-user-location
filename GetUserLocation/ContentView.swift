//
//  ContentView.swift
//  GetUserLocation
//
//  Created by Danh Tu on 27/09/2021.
//

import CoreLocationUI
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .tint(.pink)
            
            LocationButton(.currentLocation) {
                viewModel.requestAllowOnceLocationPermission()
            }
            .foregroundColor(.white)
            .cornerRadius(10)
            .labelStyle(.titleAndIcon)
            .symbolVariant(.fill)
            .tint(.pink)
            .padding(.bottom)
        }
    }
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            // Show an error
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
