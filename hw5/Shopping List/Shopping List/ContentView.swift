//
//  ContentView.swift
//  Shopping List
//
//  Created by Tony Hong on 3/11/22.
//

import SwiftUI
class Items : Identifiable{
    
    let imageName : String
    
    let itemName : String
    
    let quantity : Int
    
    init(Image : String, Item : String, Amount : Int ){
        self.imageName = Image
        self.itemName = Item
        self.quantity = Amount
    }
}
struct ContentView: View {
    var list = [
        Items(Image: "banana", Item: "Bananas", Amount: 3),
        Items(Image: "apple", Item: "Apple", Amount: 4),
        Items(Image: "orange", Item: "orange", Amount: 12)
    ]
    var list1 = [
        Items(Image: "coffee", Item: "coffee", Amount: 3),
        Items(Image: "milk", Item: "milk", Amount: 4)
        
    ]
    var list2 = [
        Items(Image: "eggs", Item: "Eggs", Amount: 12),
        Items(Image: "cheeze", Item: "cheeze", Amount: 2)
        ]
  
    

    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Fruits")) {
                    ForEach(list){i in
                        CustomCell(imageName: i.imageName, itemName: i.imageName, quantity: i.quantity)
                    }
                }
                Section(header: Text("Drinks")) {
                    ForEach(list1){i in
                        CustomCell(imageName: i.imageName, itemName: i.imageName, quantity: i.quantity)
                    }
                }
                Section(header: Text("Other")) {
                    ForEach(list2){i in
                        CustomCell(imageName: i.imageName, itemName: i.imageName, quantity: i.quantity)
                    }
                }
            }.navigationTitle("Shopping List")
    }
    }
}
