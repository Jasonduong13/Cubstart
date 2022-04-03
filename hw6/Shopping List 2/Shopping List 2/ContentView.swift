//
//  ContentView.swift
//  Shopping List 2
//
//  Created by Tony Hong on 3/27/22.
//

import SwiftUI

class Items: Identifiable {
    
    var itemName: String
    
    var quantity: String
    
    init(itemName: String, quantity: String) {
        
        self.itemName = itemName
        
        self.quantity = quantity
    }
    
}
struct ContentView: View {
    @State var tempItemName: String = ""
    @State var tempQuantity: String = ""
    func addItem(){
        if (tempQuantity != "" && tempItemName != ""){
            list.append(Items(itemName: tempItemName, quantity: tempQuantity))
        }
        tempItemName = ""
        tempQuantity = ""
    }
    
    func removeItem(){
        list.popLast()
    }
    
    
    @State var list = [
        Items(itemName: "Bananas", quantity: "3"),
        Items(itemName: "Apples", quantity: "4"),
        Items(itemName: "Eggs", quantity: "12")
    ]
    
        
    var body: some View {
        NavigationView {
            List {
                ForEach(list){i in
                    CustomCell(itemName: i.itemName, quantity: i.quantity)
                }
                HStack {
                    TextField("Item Name", text: $tempItemName)
                    
                    Spacer()
                    
                    TextField("Quantity", text: $tempQuantity)
                }
                
                Button("Add New Item"){
                    addItem()
                }
                
                Button("Delete Item"){
                    removeItem()
                }
            }.navigationTitle("Shopping List")
        }
    }
}
