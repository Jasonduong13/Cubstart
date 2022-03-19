//
//  CustomCell.swift
//  Shopping List
//
//  Created by Tony Hong on 3/12/22.
//

import SwiftUI

struct CustomCell: View {
    var imageName : String
    var itemName : String
    var quantity : Int

    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
            
            Text(itemName)
                .padding(.leading, 10)
                .padding(.trailing, 50)
            Spacer()
            Spacer()
            Text(String(quantity))
                .frame(maxWidth: .infinity, alignment: .center)
            
                 
        }
    }
}

