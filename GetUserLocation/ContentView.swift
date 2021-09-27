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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: 120), span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .ignoresSafeArea()
                .tint(.pink)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
