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
        ScrollView() {
            VStack(alignment: .leading){
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay{
                        VStack(){
                            Image(systemName: "heart")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                                .padding()
                                .font(.system(size:30))
                                .foregroundColor(.white)
                                .padding(.top, 40)
                        }
                        VStack(alignment: .leading, spacing: 5){
                            Text(restaurant.name)
                                .font(.system(size:35))
                                .bold()
                            Text(restaurant.type)
                                .font(.system(.headline, design: .rounded))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                        .foregroundColor(.white)
                        .padding()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                }
            }
        }
    }
}

#Preview {
    RestaurantDetailView(restaurant: Restaurant(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", image: "cafedeadend", isFavorite: true))
}
