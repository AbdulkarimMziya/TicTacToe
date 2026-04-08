//
//  SmallWidgetView.swift
//  TicTacToe
//
//  Created by Abdulkarim Mziya on 2026-04-08.
//

import SwiftUI

struct SmallWidgetView: View {
    var entry: ScoreEntry
    
    private let neonBlue = Color(uiColor: .neonBlue)
    private let neonRed = Color(uiColor: .neonRed)
    
    var body: some View {
        
        let total = entry.playerXScore + entry.losses
        let percent = total == 0 ? 0.5 : Double(entry.playerXScore) / Double(total)
        
        VStack {
            HStack {
                Text("W")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(neonBlue)
                Spacer()
                Text("L")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(neonRed)
            }
            
            Spacer()
            
            HStack {
                Text("\(entry.playerXScore)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(neonBlue)
                Spacer()
                Text("\(entry.losses)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(neonRed)
            }
            
            ProgressView(value: percent)
                .tint(neonBlue)
                .background(neonRed)
                .clipShape(.capsule)
                .scaleEffect(x: 1, y: 1.5)
            
            Spacer()
        }
        .padding()
    }
}
