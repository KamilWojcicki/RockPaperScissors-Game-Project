//
//  test.swift
//  RockPaperScissors
//
//  Created by Kamil Wójcicki on 09/03/2023.
//

import SwiftUI

struct test: View {
    private let game = ["rock", "paper", "scissors"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var shouldWin = Bool.random()
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rounds = 0
    @State private var endGame = false
    var toWin: String{
        if game[currentChoice] == game[0]{
            return "paper"
        }else if game[currentChoice] == game[1]{
            return "scissors"
        }else{
            return "rock"
        }
    }
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            VStack{
                Text("Rock, Paper, Scissors game")
                    .font(.title)
                    .frame(maxWidth: 350)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                HStack(alignment: .top){//poziomy
                    VStack{//pionowy
                        Text("App move:")
                        //Spacer()
                            //.frame(height: 10)
                           // .offset(y: -22)
                        ForEach(0..<3){ option in
                            Text(game[option])
                        }
                        //.background(.red)
//                        Text(game[currentChoice])
//                            .foregroundColor(.black)
                            
                            
                    }
                    // .background(.red)
                    
                    Spacer()
                    VStack{
                        Text("Your goal is to:")
                            // .offset(y: -15)
                        Text(shouldWin ? "Win" : "Lose")
                            .foregroundColor(.red)
                            .font(.title)
                            .fontWeight(.bold)
                        
                    }
                    Spacer()
                    VStack{
                        
                        Text("Your move:")
                        ForEach(0..<3){ option in
                            Button{
                                playerChoose(userOption: option)
                            } label: {
                                Text(game[option])
                            }
                        }
                    }
                    
                   // .frame(alignment: .trailing)
                    
                }
                
               // .frame(alignment: .leading)
                .frame(maxWidth: .infinity)
               //.background(.gray)
                .padding()
                Text("Player scores: \(score)")
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
        score = 0
    }
    }


struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
