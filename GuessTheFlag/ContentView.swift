//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Joao Leal on 8/29/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["US", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var yourScore = 0
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
           
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 30) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                           
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3)  {  number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 5))
                                .shadow(radius: 5)
                        }
                    }  }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Score: \(yourScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(yourScore)")
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            yourScore += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
