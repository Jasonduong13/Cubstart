//
//  ContentView.swift
//  Bullseye with SwiftUI
//
//  Created by Tony Hong on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showGreeting = true
    @State private var celsius: Double = 0
    
    var body: some View {
        VStack() {
            HStack() {
                VStack() {
                    Text("High Score")
                    Text("0")
                }
                .padding(.leading, 30)
                
                Spacer()
                
                VStack() {
                    Text("Current Level")
                    Text("1")
                }
                .padding(.trailing, 30)
            }
            
            Spacer()
            
            VStack(){
                Text("Move slider to:").font(.system(size: 35.0))
            }
            
            .padding(.bottom,10)
        
            
            VStack(){
                Text("\(celsius, specifier: "%.0f")").font(.system(size: 35.0))
                Slider(value: $celsius, in: 0...100)
                    .padding()
            }
            .padding(.bottom,0)
            
            VStack(){
                Button("Check") {
                    print("Checking")
                }            }
            .padding(.bottom,150)
            
            VStack(){
                Text("Exact Mode Toggler").font(.system(size: 25.0))
            }
            VStack(){
                Toggle("", isOn: $showGreeting)
                    .padding(.trailing,170)
                 if showGreeting {
                    Text("EXACT MODE ON")
                }
                
            }
            .padding(.bottom,10)
            
                
        }
        .padding(.top, 15)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
