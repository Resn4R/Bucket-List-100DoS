//
//  PinView.swift
//  Bucket List
//
//  Created by Vito Borghi on 19/11/2023.
//

import SwiftUI
import MapKit

struct PinView: View {
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @State var pin: Location
    @State var cameraPosition: MapCameraPosition
    @State private var loadingState: LoadingState = .loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationStack {
            Section {
                Text(pin.locationDescription)
            }
            .padding()
            Spacer()
            
            Divider()
                .frame(width: 350)
            
            Text("What's nearby...")
            ScrollView {
                switch loadingState {
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .loaded:
                    VStack(alignment: .leading) {
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                        
                    }
                case .failed:
                    ContentUnavailableView("Content Unavailable", systemImage: "tray.and.arrow.down", description: Text("Failed to fetch nearby locations.\nPlease try again."))
                }
            }
            .frame(width:350 ,height: 300)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            Spacer()
            
            Divider()
                .frame(width: 350)

            Spacer()
            
            ZStack {
                Map(initialPosition: cameraPosition)
                    .mapControls{
                        MapScaleView()
                    }
                    .disabled(true)
                    .onAppear{
                        let locationCoordinates = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                        let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
                        cameraPosition = .region(mapRegion)
                    }
                    .frame(width: 350, height: 275)
                    .border(Color.convertFromString(pin.pinColour))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack {
                    Image(systemName: "mappin")
                    Text(pin.name)
                }
            }
            
            .navigationTitle(pin.name)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: EditCustomPinView(locationToEdit: pin, cameraPosition: cameraPosition)) {
                        Text("Edit")
                    }
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(pin.latitude)%7C\(pin.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Bad url: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
    
}

//#Preview {
//    let location = Location(id: UUID(), name: "Sample", locationDescription: "ASDASDASDADS", pinColour: "blue", latitude: 51.5, longitude: -0.12)
//    PinView(pin: location, cameraLocation: MapCameraPosition.automatic)
//}
