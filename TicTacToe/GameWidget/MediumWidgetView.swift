//
//  MediumWidgetView.swift
//  GameWidgetExtension
//
//  Created by Abdulkarim Mziya on 2026-04-08.
//

import SwiftUI

struct MediumWidgetView: View {
    var entry: ScoreEntry
    
    private let neonBlue = Color(uiColor: .neonBlue)
    private let neonRed = Color(uiColor: .neonRed)
    
    var body: some View {
        HStack(spacing: 0) {
            // LEFT SIDE: The Core Stats (similar to Small View)
            VStack(alignment: .leading, spacing: 8) {
                Text("RECORD")
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(entry.playerXScore)")
                        .font(.system(size: 34, weight: .black))
                        .foregroundStyle(neonBlue)
                    Text("WINS")
                        .font(.caption2.bold())
                        .foregroundStyle(neonBlue.opacity(0.8))
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(entry.losses)")
                        .font(.system(size: 34, weight: .black))
                        .foregroundStyle(neonRed)
                    Text("LOSSES")
                        .font(.caption2.bold())
                        .foregroundStyle(neonRed.opacity(0.8))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // RIGHT SIDE: The Win/Loss Ratio Visual
            VStack(spacing: 12) {
                let total = entry.playerXScore + entry.losses
                let ratio = total == 0 ? 0.0 : Double(entry.playerXScore) / Double(total)
                
                Text("WIN %")
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                
                ZStack {
                    
                    Circle()
                        .stroke(neonRed.opacity(0.2), lineWidth: 8)
                    Circle()
                        .trim(from: 0, to: ratio)
                        .stroke(neonBlue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(ratio * 100))%")
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                }
                .frame(height: 70)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
    }
}
