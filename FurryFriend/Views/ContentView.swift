//
//  ContentView.swift
//  FurryFriends
//
//  Created by Russell Gordon on 2022-02-26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentImage = catsImage(file: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")
    @State var currentImageAddedToFavourites: Bool = false
    @State var favourites: [RemoteImageView] = []
    
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            
            // Shows the main image
            RemoteImageView(fromURL: URL(string: currentImage.file)!)
            HStack{
                Image(systemName: "heart.circle")
                    .padding()
                    .foregroundColor(currentImageAddedToFavourites == true ? .red : .secondary)
                Spacer()
                Image(systemName: "x.circle")
                    .padding()
                
            }
            .frame(width: 40, height: 40)
            
            
            // Push main image to top of screen
            Spacer()
            HStack{
                Text("Favourite")
                    .padding()
                Spacer()
                
                
            }
            
            
            List{
                Text("favourite")
                Text("favourite")
                Text("favourite")
            }
            
        }
        // Runs once when the app is opened
        .task {
            await loadNewImage()
                        
        }

        .navigationTitle("Furry Friends")
        
    }
    
    // MARK: Functions
    func loadNewImage() async{
        let url = URL(string: "https://aws.random.cat/meow")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let urlSession = URLSession.shared
        do{
            let (data, _) = try await urlSession.data(for: request)
            currentImage = try JSONDecoder().decode(catsImage.self, from: data)
            currentImageAddedToFavourites = false
        } catch{
            print("could not retreive or decode the JSON from endpoint")
            print(error)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
