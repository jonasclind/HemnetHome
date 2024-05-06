//
//  ContentView.swift
//  HemnetHome
//
//  Created by Jonas Lind on 2024-05-06.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                
                ForEach(viewModel.highlightedProperties, id: \.id) { property in
                    NavigationLink(destination: HomeDetailView(viewModel: viewModel, property: property)) {
                        HomeRowView(home: property, isHighlighted: true)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                if let area = viewModel.area {
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

                ForEach(viewModel.properties, id: \.id) { property in
                    NavigationLink(destination: HomeDetailView(viewModel: viewModel, property: property)) {
                        HomeRowView(home: property)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct HomeRowView: View {
    var home: Property
    var isHighlighted: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            AsyncImage(url: URL(string: home.image)) { image in
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

            Text(home.streetAddress)
                .font(.headline)
            
            Text("\(home.area), \(home.municipality)")
                .font(.subheadline)
            
            HStack {
                Text("\(home.askingPrice) SEK")
                Spacer()
                Text("\(home.livingArea) m2")
                Spacer()
                Text("\(home.numberOfRooms) rooms")
            }
            .frame(width: .infinity)
            .font(.subheadline)
            .fontWeight(.bold)
        }
        .padding(20)
    }
}

struct HomeDetailView: View {
    @ObservedObject var viewModel: HomeViewModel
    var property: Property

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
            
                if let details = viewModel.homeDetails {
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
            viewModel.fetchHomeDetails(for: property.id)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
