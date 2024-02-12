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
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's chocolate", "Palomino Espresso"]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino"]
    
    var body: some View {
        List {
            ForEach(restaurantNames.indices, id: \.self) { index in
                HStack(alignment: .top, spacing: 20) {
                    Image(restaurantImages[index])
                        .resizable()
                        .cornerRadius(20)
                    .frame(width: 120, height: 120)
                    VStack(alignment: .leading) {
                        Text(restaurantNames[index])
                        Text("Type:")
                            .font(.system(.body, design: .rounded))
                        Text("Location:")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    RestaurantListView()
        .preferredColorScheme(.dark)
        .modelContainer(for: Item.self, inMemory: true)
}
