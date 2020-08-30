//
//  ContentView.swift
//  Bullseye
//
//  A game that asks a user to match the slider's position with a given value.
//
//  Created by Tanarut Chaisuesomboon on 8/30/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //colors
    let midnightBlue = Color(red: 0, green: 0.2, blue: 0.4)
    
    //Game stats
    @State var alertisVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    var sliderValueRounded: Int{
    Int(self.sliderValue.rounded())
    }
    var sliderValueDifference: Int{
        abs(self.sliderValueRounded - self.target)
    }
    @State var score = 0
    @State var round = 1
    
    //body of the Content View
    var body: some View {
        //adds navigation to the app
        NavigationView {
            VStack {
                Spacer().navigationBarTitle("🎯 Bullseye 🎯")
                //Target row
                HStack {
                    Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                    Text("\(target)")
                    .modifier(ValueStyle())

                }
                Spacer()
                //Slider row
                HStack {
                    Text("1")
                    .modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                        .animation(.easeOut)
                    Text("100")
                    .modifier(LabelStyle())

                }
                
            Spacer()
            //Button row
            Button(action: {
                self.alertisVisible = true
            }) {
                Text("Hit me!").modifier(ButtonLargeTextStyle())
            }
            .background(Image("Button-Normal"))
            .modifier(Shadow())

            .alert(isPresented: $alertisVisible){
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("Awesome!")) {
                        self.startNewRound()
                    }
                )
            }
            Spacer()
            //Score row
            HStack{
                Button(action: {self.startNewGame()}) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtomSmallTextStyle())
                    }
                }
                .background(Image("Button-Normal"))
                .modifier(Shadow())

                Spacer()
                
                //score
                Text("Score: ")
                    .modifier(LabelStyle())
                Text("\(score)")
                    .modifier(ValueStyle())
                
                Spacer()
                
                //round
                Text("Round:")
                .modifier(LabelStyle())
                Text("\(round)")
                .modifier(ValueStyle())
                
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoButton")
                        Text("Info").modifier(ButtomSmallTextStyle())
                    }
                }
            
                .background(Image("Button-Normal"))
                .modifier(Shadow())
                }

            .padding(.bottom, 20)
            .accentColor(midnightBlue)
            }
            .onAppear(){
            self.startNewGame()
            }
                
            .background(Image("Background"))

        }

    }
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let points: Int
        if sliderValueDifference == 0{
            points = 200
        }
        else if sliderValueDifference == 1{
            points = 150
        }
        else{
            points = maximumScore - sliderValueDifference
        }
        return points
    }
    
    func scoringMessage() -> String {
    return "The slider's value is \(Int(sliderValueRounded)).\n" +
    "The target value is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
    
    func alertTitle() -> String {

        let title: String
        if(sliderValueDifference == 0){
            title = "Perfect!"
        }
        else if sliderValueDifference < 5{
            title = "You almost had it!"
        }
        else if sliderValueDifference <= 10{
            title = "Not bad!"
        }
        else{
            title = "Are you even trying?"
    }
        return title
    }
    
    func startNewGame(){
        score = 0
        round = 1
        resetSliderAndTarget()

    }
    
    func startNewRound(){
        score = score + pointsForCurrentRound()
        round = round + 1
        resetSliderAndTarget()

    }
    
    func resetSliderAndTarget(){
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
    //Methods
}

struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .foregroundColor(Color.white)
        .modifier(Shadow())
    }
}

struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
        content
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
        .foregroundColor(Color.yellow)
        .modifier(Shadow())
    }
}

struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black, radius: 5, x:2, y:2)
    }
}

struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.black)
    }
}

struct ButtomSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(Color.black)
    }
}

//Preview
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

