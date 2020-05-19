//
//  ContentView.swift
//  Bullseye
//
//  Created by Pedro Sequeira on 26/04/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.white)
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(ShadowStyle())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .foregroundColor(Color.yellow)
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.black)
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
                .foregroundColor(Color.black)
        }
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }
            
            Spacer()
            
            HStack(spacing: 2.0) {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                    .padding(.horizontal, 10)
                    .accentColor(Color.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
                    .modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let roundedValue = Int(self.sliderValue.rounded() )
                return Alert(
                    title: Text(getAlertTitle()),
                    message: Text(
                        "The slider's value is \(roundedValue).\n" +
                        "You scored \(pointsForCurrentRound()) points this round."),
                    dismissButton: .default(Text("Next round!")) {
                        self.score += self.pointsForCurrentRound()
                        self.round += 1
                        self.target = self.getRandomNumber()
                    }
                )
            }
            .background(Image("Button"))
            .modifier(ShadowStyle())
            
            Spacer()
            
            HStack() {
                
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                            .modifier(ButtonSmallTextStyle())
                        
                    }
                }
                .background(Image("Button"))
                .modifier(ShadowStyle())
                
                Spacer()
                
                Text("Score:")
                    .modifier(LabelStyle())
                
                Text("\(score)")
                    .modifier(ValueStyle())
                
                Spacer()
                
                Text("Round:")
                    .modifier(LabelStyle())
                
                Text("\(round)")
                    .modifier(ValueStyle())
                
                Spacer()
                
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button"))
                .modifier(ShadowStyle())
                
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
            .padding(.trailing, 40)
        }
        .background(Image("Background"))
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func amountOff() -> Int {
        return abs(target - Int(self.sliderValue.rounded()))
    }
    
    func pointsForCurrentRound() -> Int {
        return 100 - amountOff() + self.bonusPoints()
    }
    
    func getRandomNumber() -> Int {
        return Int.random(in: 1...100)
    }
    
    func getAlertTitle() -> String {
        let difference = amountOff()
        let title: String
        switch difference {
        case 0:
            title = "Perfect!"
        case 0..<6:
            title = "You almost had it!"
        case 0..<11:
            title = "Not bad."
        default:
            title = "Are you even trying?"
        }
        return title
    }
    
    func bonusPoints() -> Int {
        let difference = amountOff()
        switch difference {
        case 0:
            return 100
        case 1:
            return 50
        default:
            return 0
        }
    }
    
    func startNewGame() {
        self.round = 1
        self.score = 0
        self.target = self.getRandomNumber()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(
            .fixed(width: 896, height: 414))
    }
}
