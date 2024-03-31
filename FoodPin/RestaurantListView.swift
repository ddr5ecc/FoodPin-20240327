//
//  ContentView.swift
//  FoodPin
//
//  Created by Stephen Lin on 2/5/24.
//
// Hello!

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    // ??
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]


    // 以下設定餐廳陣列，目前陣列無法更動
    @State var restaurants = [
    Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location:
    "Hong Kong", image: "cafedeadend", isFavorite: false),
    Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:
    "homei", isFavorite: false),
    Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
    Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
    Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong"
    , image: "petiteoyster", isFavorite: false),
    Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
    Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong"
    , image: "posatelier", isFavorite: false),
    Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:
    "Sydney", image: "bourkestreetbakery", isFavorite: false),
    Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney"
    , image: "haigh", isFavorite: false),
    Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
    Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
    Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
    Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
    Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
    Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
    Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
    Restaurant(name: "Confessional", type: "Spanish", location: "New York"
    , image: "confessional", isFavorite: false),
    Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
    Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
    Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
    Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)]

    var body: some View {

        // 將整個 View 裝在 NavigationView 之內，就可以導航了
        NavigationView {
            List {
                // ForEach 重覆呼叫每個 View 
                ForEach(restaurants.indices, id: \.self) { index in
                    ZStack {
                        // 包在 NavigationLink 之內的就變成了超鏈結，可以往下一層 View 前進
                        // 最底層是 NavigationLink
                        // 往上一層才是影像與文字，並非包在NavigationLink之中
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurants[index])){
                            EmptyView() // 這個 EmptyView() 做什麼用? 
                        }
                        .opacity(0)
                        .swipeActions(edge: .leading, allowsFullSwipe: false, content:{
                            // 自左向右滑物件出現以下按鈕，指定兩個按鈕
                            // 依附NavigationLink
                                Button{
                                    
                                } label: {
                                    Image(systemName: "heart")
                                    .tint(.green)
                                }
                                Button{
                                    
                                } label: {
                                    Image(systemName: "square.and.arrow.up")
                                }
                                .tint(.orange)
                        })
                        BasicTextImageRow(restaurant: $restaurants[index])
                            // 將傳入 restaurant struct(物件)
                            // 後方有定義，這是一個 View, 包含影像與文字
                            // 呼叫 View 的方式可以讓程式更易閱讀
                            // 要列出什麼就直接寫在 View 之內就好
                    }
                }
                .onDelete(perform: {indexSet in restaurants.remove(atOffsets: indexSet)})
                    // 自右向左滑，移除 restaurant List 的該元素
                    // 依附於 ForEach
                .listRowSeparator(.hidden)
            }
            // 以下三點是在NavigationView之內，不是依附
            .listStyle(.plain)
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.automatic)
        }
    } // Navigation View 結束
} // body 結束

struct RestaurantListView_Previews: PreviewProvider{
    static var previews: some View{
        RestaurantListView()
        
        RestaurantListView()
            .preferredColorScheme(.dark)
    }
}

// 每一列要如何顯示餐廳，全部定義在下面這個 struct
// 呼叫的時候會接收 restaurant struct 做為參數，但下方設定時只用 var 宣告
struct BasicTextImageRow: View {    // 與函數不同，這邊並不寫明要接收參數
    
    @Binding var restaurant: Restaurant        // 雙向鏈結餐廳物件，我猜接收參數與這一行有關
    @State private var showOptions = false    // 是否顯示 Options
    @State private var showError = false    // 是否顯示 Error
 
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(restaurant.image)    // 取得餐廳物件的影像
                .resizable()
                .frame(height: 200)
                .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                if restaurant.isFavorite {    // 有條件顯示愛心
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        
        // 長按餐廳物件的動作，依附在整個 HStack, 這樣按在哪裡都會出現子選單
        .contextMenu{
            Button(action: {
                self.showError.toggle()    // 因為還沒寫好因此秀出錯誤訊息
            }) {
                HStack{
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            Button(action: {
                self.restaurant.isFavorite.toggle()
            }) {
                HStack{
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            Button(action:{
                self.showOptions.toggle()
            }){
                HStack{
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
        }

        // 在選單中有指定 $showError, 使用 .alert 來叫出警告視窗，依附在 HStack
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"),
                  message: Text("Sorry, this feature is not available yet. Please retry later."),
                  primaryButton: .default(Text("OK")),
                  secondaryButton: .cancel())
        }

        // 自下方拉出 Action Sheet, 並有其他功能可選
        .sheet(isPresented: $showOptions){
            let defaultText = "Just checking in at \(restaurant.name)"
                // 顯示正常，但只能被…拷貝嗎? 

            // 以下的部分並沒有顯示出來，是 UIImage 設定錯誤嗎? 
            if let imageToShare = UIImage(named: restaurant.image){
                ActivityView(activityItems: [defaultText, imageToShare])
            }
            else{
                ActivityView(activityItems: [defaultText])
            }
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
