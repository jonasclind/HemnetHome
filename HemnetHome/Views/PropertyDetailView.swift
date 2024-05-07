//
//  PropertyDetailView.swift
//  HemnetHome
//
//  Created by Jonas Lind on 2024-05-06.
//

import SwiftUI

struct PropertyDetailView: View {
    @ObservedObject var viewModel: PropertyViewModel
    var property: Property
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                if let details = viewModel.propertyDetails {
                    AsyncImage(url: URL(string: details.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 10)
                    
                    Text(details.streetAddress)
                        .font(.title)
                    
                    Text("\(details.area), \(details.municipality)")
                    
                    Text("\(details.askingPrice) SEK")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    Text(details.description)
                        .font(.caption)
                        .padding(.bottom, 30)
                        .lineSpacing(10)
                    
                    Text("**Living area:** \(details.livingArea) m2")
                    Text("**Number of rooms:** \(details.numberOfRooms)")
                    Text("**Patio:** \(details.patio)")
                    Text("**Days since publish:** \(details.daysSincePublish)")
                }
            }
            .font(.subheadline)
            .padding(20)
        }
        .onAppear {
            viewModel.fetchPropertyDetails(for: property.id)
        }
    }
}

struct PropertyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyDetailView(viewModel: PropertyViewModel(), property: Property(
            id: "1234567890", 
            askingPrice: 1000000, 
            monthlyFee: 5000, 
            municipality: "Stockholm", 
            area: "Södermalm", 
            daysSincePublish: 5, 
            livingArea: 50, 
            numberOfRooms: 2, 
            streetAddress: "Testgatan 1", 
            image: "https://example.com/image.jpg")
        )
    }
}

