//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kamil Wójcicki on 08/03/2023.
//

import SwiftUI
struct TextModify: ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .font(.title2)
            .multilineTextAlignment(.center)
    }
}

extension View{
    func textStyle() -> some View{
        modifier(TextModify())
    }
}
struct ContentView: View {
    private let game = ["🪨", "📄", "✂️"]
    private let names = ["rock", "paper", "scissors"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var shouldWin = Bool.random()
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rounds = 0
    @State private var endGame = false
    @State private var selectedItem = false
    @State private var highestScore = 0
    var toWin: String{
        if game[currentChoice] == game[0]{
            return "📄"
        }else if game[currentChoice] == game[1]{
            return "✂️"
        }else{
            return "🪨"
        }
    }
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.3, green: 0.7, blue: 0.8), location: 0.3),
                .init(color: Color(red: 0.2, green: 0.3, blue: 0.9), location: 0.9)
            ], center: .bottom, startRadius: 100, endRadius: 600)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Rock, Paper, Scissors game")
                    .font(.title)
                    .frame(maxWidth: 350, maxHeight: 50)
                    .foregroundColor(.white)
                    .border(.thinMaterial, width: 6)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                HStack(alignment: .top){//poziomy
                    VStack{//pionowy
                        Text("App move:")
                            .textStyle()
                            .foregroundStyle(.secondary)
                        ForEach(0..<3, id: \.self){ option in
                            
                            if option == currentChoice{
                                Text(game[option])
                                    .font(.custom("80px", size: 80))
                                    .frame(width: 100)
                                Text(names[option])
                                    .font(.title)
                                    .foregroundColor(Color(red:0.6, green: 0.1, blue:0.3))
                            }else{
                                Text(game[option])
                                    .font(.custom("60px", size: 60))
                                    .frame(width: 100)
                                Text(names[option])
                                    .font(.title)
                            }
                        }
                    }
                    
                    Spacer()
                    VStack{
                        Text("Your goal is to:")
                            .textStyle()
                            .foregroundStyle(.secondary)
                            
                        Text(shouldWin ? "Win" : "Lose")
                            .foregroundColor(.red)
                            .font(.title)
                            .fontWeight(.bold)
                            .offset(y: 15)
                        
                    }
                    Spacer()
                    VStack{
                        
                        Text("Your move:")
                            .textStyle()
                            .foregroundStyle(.secondary)
                        ForEach(0..<3){ option in
                            Button{
                                playerChoose(userOption: option)
                            } label: {
                                VStack{
                                    Group{
                                        Text(game[option])
                                            .font(.custom("80px", size: 60))
                                           // .frame(width: 100)
                                        Text(names[option])
                                            .font(.title)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
               // .frame(alignment: .leading)
                //.frame(maxWidth: .infinity)
               //.background(.gray)
                .padding(10)
                Spacer()
                Text("Player scores: \(score)")
                    .textStyle()
                    .foregroundStyle(.primary)
                Text("High score: \(highestScore)")
                    .padding(5)
                
                Spacer()
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your score is \(score)")
        }
        .alert("Game over", isPresented: $endGame){
            Button("Reset game", action: gameOver)
        }message: {
            Text("Your final score is: \(score)")
        }
    }
    func playerChoose(userOption: Int){
        rounds += 1
        if game[userOption] == toWin && shouldWin == true{
            scoreTitle = "Correct!"
            score += 1
        }else if game[userOption] == toWin && shouldWin == false{
            scoreTitle = "Wrong!"
        }else if game[userOption] != toWin && shouldWin == true{
            scoreTitle = "Wrong!"
        }else{
            scoreTitle = "Correct!"
            score += 1
        }
        //showingScore = true
        if rounds < 10{
            showingScore = true
        }else{
            showingScore = true
            endGame = true
        }
    }
    func askQuestion(){
        currentChoice = Int.random(in: 0...2)
        //game.shuffle()
        shouldWin.toggle()
    }
    
    func gameOver(){
        askQuestion()
        rounds = 0
        if score > highestScore{
            highestScore = score
        }
        score = 0
    }
    func highScore(){
        if score > highestScore{
            highestScore = score
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
