//
//  PropertyView.swift
//  HemnetHome
//
//  Created by Jonas Lind on 2024-05-06.
//

import SwiftUI

struct PropertyView: View {
    @StateObject private var viewModel = PropertyViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                HighlightedPropertiesView(viewModel: viewModel)
                
                AreaView(area: viewModel.area)

                PropertyListView(viewModel: viewModel)
            }
            .refreshable {
                viewModel.fetchProperties()
            }
            .onAppear {
                viewModel.fetchProperties()
            }
        }
    }
}

struct HighlightedPropertiesView: View {
    @ObservedObject var viewModel: PropertyViewModel

    var body: some View {
        ForEach(viewModel.highlightedProperties, id: \.id) { property in
            NavigationLink(destination: PropertyDetailView(viewModel: viewModel, property: property)) {
                PropertyRowView(property: property, isHighlighted: true)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct AreaView: View {
    var area: Area?

    var body: some View {
        if let area = area {
            VStack(alignment: .leading, spacing: 10) {
            
                VStack(alignment: .leading, spacing: 5) {
                    Text("Area")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    AsyncImage(url: URL(string: area.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: .infinity)
                            .frame(height: 150)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom, 5)
                    
                    Text(area.area)
                        .fontWeight(.bold)
                    Text("Rating: \(area.ratingFormatted)")
                    Text("Average price: \(area.averagePrice) m2")
                }
                .font(.subheadline)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

struct PropertyListView: View {
    @ObservedObject var viewModel: PropertyViewModel

    var body: some View {
        ForEach(viewModel.properties, id: \.id) { property in
            NavigationLink(destination: PropertyDetailView(viewModel: viewModel, property: property)) {
                PropertyRowView(property: property)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct PropertyRowView: View {
    var property: Property
    var isHighlighted: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            AsyncImage(url: URL(string: property.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity)
                    .frame(height: isHighlighted ? 200 : 150)
                    .clipped()
                    .border(isHighlighted ? Color.yellow : Color.clear, width: 3)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 10)

            Text(property.streetAddress)
                .font(.headline)
            
            Text("\(property.area), \(property.municipality)")
                .font(.subheadline)
            
            HStack {
                Text("\(property.askingPrice) SEK")
                Spacer()
                Text("\(property.livingArea) m2")
                Spacer()
                Text("\(property.numberOfRooms) \(property.numberOfRooms > 1 ? "rooms" : "room")")
            }
            .frame(width: .infinity)
            .font(.subheadline)
            .fontWeight(.bold)
        }
        .padding(20)
    }
}

struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyView()
    }
}
