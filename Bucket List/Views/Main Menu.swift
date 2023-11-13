//
//  Main Menu.swift
//  Bucket List
//
//  Created by Vito Borghi on 08/11/2023.
//
import MapKit
import CoreLocation
import SwiftData
import SwiftUI

struct CustomText: View {
    @State var text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .bold()
            .fontDesign(.serif)
            .padding()
    }
}

struct Main_Menu: View {
    @Environment (\.modelContext) var modelContext
    @Query var locations: [Location]

    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .region(.defaultRegion))
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomText(text: "Add a new pin to your Bukkit")
                        .offset(y: 30)
                    
                    NavigationLink(destination: MapView(cameraPosition: $cameraPosition), label: {
                        Map(initialPosition: cameraPosition){
                            UserAnnotation()
                        }
                        .frame(width: 350, height: 175)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .disabled(true)
                    })
                    .padding()
                    Section {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.gray)
                                .frame(minWidth: 350, minHeight: 270, maxHeight: .infinity)
                                .opacity(0.1)
                            VStack{
                                CustomText(text: "Your Saved Locations")
                                
                                Divider()
                                    .frame(width: 350)
                                
                                if locations.isEmpty{
                                    ContentUnavailableView("No saved pins", systemImage: "mappin.slash.circle", description: Text("You have no saved pins.\nClick on the map above to add new pins."))
                                } else {
                                    List {
                                        ForEach(locations) { location in
                                            
                                            let locationCoordinates = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                                            let mapRegion = MKCoordinateRegion(center: locationCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
                                            let cameraPosition: MapCameraPosition = .region(mapRegion)
                                            
                                            NavigationLink(destination:EditCustomPinView(locationToEdit: location, cameraPosition: cameraPosition)) {
                                                HStack {
                                                    Image(systemName: "mappin")
                                                    Text(location.name)
                                                }
                                            }
                                        }
                                        .onDelete { indexSet in
                                            withAnimation {
                                                indexSet.forEach { index in
                                                    let pinToDelete = locations[index]
                                                    modelContext.delete(pinToDelete)
                                                }
                                            }
                                            do { try modelContext.save() }
                                            catch {
                                                print("Error when saving from item deletion. \(error.localizedDescription)")
                                            }
                                        }
                                        
                                    }
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .frame(width: 350)
                    }
                }
            }
            .navigationTitle("Bukkit")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    Main_Menu()
}
