//
//  AboutView.swift
//  Bullseye
//
//  Created by Pedro Sequeira on 28/04/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let orange = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct TitleStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .padding(.vertical, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .padding(.horizontal, 60)
                .padding(.bottom, 20)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(TitleStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(TextStyle())
                Text("Your goal is to place the slider as close as possible to the target value.")
                    .modifier(TextStyle())
                Text("The closer you are, the more points you score.")
                    .modifier(TextStyle())
                Text("Enjoy!")
                    .modifier(TextStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(orange)
        }
    .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(
            .fixed(width: 896, height: 414))
    }
}
