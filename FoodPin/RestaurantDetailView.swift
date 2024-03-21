//
//  RestaurantDetailView.swift
//  FoodPin
//
//  Created by Stephen Lin on 3/11/24.
//

import SwiftUI

struct RestaurantDetailView: View {
    @Environment(\.dismiss) var dismiss
    var restaurant: Restaurant
    var body: some View {
        ZStack(alignment: .top) {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            .ignoresSafeArea()
            
            Color.black
                .frame(height: 100)
                .opacity(0.8)
                .cornerRadius(20)
                .padding()
                .overlay{
                    VStack(spacing: 5){
                        Text(restaurant.name)
                        Text(restaurant.type)
                        Text(restaurant.location)
                    }
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.white)
                }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    dismiss()
                }) {
                    Text("\(Image(systemName: "chevrom.left")) \(restaurant.name)")
                }
            }
        }
    }
}

#Preview {
    RestaurantDetailView(restaurant: Restaurant(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", image: "cafedeadend", isFavorite: true))
}