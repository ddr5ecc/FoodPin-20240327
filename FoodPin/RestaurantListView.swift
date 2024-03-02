//
//  ContentView.swift
//  FoodPin
//
//  Created by Stephen Lin on 2/5/24.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    /*
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's chocolate", "Palomino Espresso"]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Casual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney"]
    @State var restaurantIsFavorites = Array(repeating: false, count:10)
    */
    
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false)]
    /*
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                BasicTextImageRow(imageName: restaurantImages[index], name: restaurantNames[index], type: restaurantTypes[index], location: restaurantLocations[index], isFavorite: $restaurantIsFavorites[index])
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    */
    var body: some View {
        List {
            ForEach(restaurants.indices, id: \.self) { index in
                BasicTextImageRow(imageName: restaurants[index].image, name: restaurants[index].name, type: restaurants[index].type, location: restaurants[index].location, isFavorite: $restaurants[index].isFavorite)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct RestaurantListView_Previews: PreviewProvider{
    static var previews: some View{
        RestaurantListView()
        
        RestaurantListView()
            .preferredColorScheme(.dark)
        
        BasicTextImageRow(imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", isFavorite: .constant(true))
            .previewLayout(.sizeThatFits)
        FullImageRow(imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", isFavorite: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
/*
#Preview {
    RestaurantListView()
        .preferredColorScheme(.dark)
        .modelContainer(for: Item.self, inMemory: true)
    
    BasicTextImageRow(imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", isFavorite: .constant(true))
        .previewLayout(.sizeThatFits)
    FullImageRow(imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", isFavorite: .constant(true))
        .previewLayout(.sizeThatFits)
}
*/
struct BasicTextImageRow: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    @State private var showOptions = false
    @State private var showError = false
    @Binding var isFavorite: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageName)
                .resizable()
                .frame(height: 200)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))
                Text(type)
                    .font(.system(.body, design: .rounded))
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                if isFavorite {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onTapGesture{
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions){
            ActionSheet(title: Text("What do you want to do?"),
                        message: nil,
                        buttons: [
                            .default(Text("Reserve a table")){
                                self.showError.toggle()
                            },
                            .default(Text("Mark as favorite")){
                                self.isFavorite.toggle()
                            },
                            .cancel()
                            ])
        
        }
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"),
                  message: Text("Sorry, this feature is not available yet. Please retry later."),
                  primaryButton: .default(Text("OK")),
                  secondaryButton: .cancel())
        }
    }
}

struct FullImageRow: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    @State private var showOptions = false
    @State private var showError = false
    @Binding var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))
                Text(type)
                    .font(.system(.body, design: .rounded))
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                if isFavorite {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onTapGesture{
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions){
            ActionSheet(title: Text("What do you want to do?"),
                        message: nil,
                        buttons: [
                            .default(Text("Reserve a table")){
                                self.showError.toggle()
                            },
                            .default(Text("Mark as favorite")){
                                self.isFavorite.toggle()
                            },
                            .cancel()
                            ])
        
        }
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"),
                  message: Text("Sorry, this feature is not available yet. Please retry later."),
                  primaryButton: .default(Text("OK")),
                  secondaryButton: .cancel())
        }
    }
}
