//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Venkata on 3/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = ["hammer", "doc.text", "scissors"]
    @State private var botChoice = "doc.text"
    @State private var winLose = false
    @State private var score = 0
    @State private var botScore = 0
    @State private var scoreTitle = ""
    @State private var showingFinalScore = false
    @State private var countGames = 0
    
    let cardsRank = ["hammer": 1, "doc.text": 2, "scissors": 3]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.1, green: 0.45, blue: 0.2), location: 0.6),
                .init(color: Color(red: 0.2, green: 0.45, blue: 0.1), location: 0.9)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color(red: 255/255, green: 100/255, blue: 20/255))
                
                Spacer()
                VStack(spacing: 25) {
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(systemName: cards[number])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(red: 200/255, green: 50/255, blue: 50/255))
                        }
                    }
                }
                Spacer()
                Spacer()
                
                Text("Your Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(Color(red: 200/255, green: 100/255, blue: 100/255))
                
                Text("Bot Score: \(botScore)")
                    .font(.title.bold())
                    .foregroundColor(Color(red: 200/255, green: 100/255, blue: 100/255))
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $winLose) {
            Button("Continue", action: nextRound)
        } message: {
            Text("You: \(score) Bot: \(botScore)")
        }
        .alert("Game Over", isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        } message: {
            Text("\( botScore > score ? "Bot" : "You") Won with Score: \( botScore > score ? botScore : score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        let result = (cardsRank[botChoice]! - cardsRank[cards[number]]!) % 3

        if result == 0 {
            scoreTitle = "Tie"
            winLose = true
        } else if result == 1 {
            scoreTitle = "Bot Won"
            botScore += 1
            winLose = true
        } else {
            scoreTitle = "You Won"
            score += 1
            winLose = true
        }
        
        countGames += 1
        if countGames > 7 {
            showingFinalScore = true
            winLose = false
        }
    }
    
    func nextRound() {
        botChoice = cards[Int.random(in: 0..<3)]
        cards.shuffle()
    }
    
    func reset() {
        if countGames > 7 {
            countGames = 0
            score = 0
            botScore = 0
        }
    }
}

#Preview {
    ContentView()
}
