//
//  GameWidget.swift
//  GameWidget
//
//  Created by Abdulkarim Mziya on 2026-04-08.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @AppStorage("playerXScore", store: UserDefaults(suiteName: .appGroup))
    var wins = 0
    
    @AppStorage("playerOScore", store: UserDefaults(suiteName: .appGroup))
    var loss = 0
    
    func placeholder(in context: Context) -> ScoreEntry {
        ScoreEntry(date: Date(), playerXScore: wins, losses: loss)
    }

    func getSnapshot(in context: Context, completion: @escaping (ScoreEntry) -> ()) {
        let entry = ScoreEntry(date: Date(), playerXScore: wins, losses: loss)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Just one entry with the current scores
        let entry = ScoreEntry(date: Date(), playerXScore: wins, losses: loss)
        
        // Policy .never means the widget only updates when the app tells it to
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }


//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct ScoreEntry: TimelineEntry {
    let date: Date
    let playerXScore: Int
    let losses: Int
}

struct GameWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}

struct GameWidget: Widget {
    let kind: String = "GameWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                GameWidgetEntryView(entry: entry)
                    .containerBackground(
                        Color(uiColor: .darkCardBG).gradient,
                        for: .widget)
            } else {
                GameWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("TicTacToe Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    GameWidget()
} timeline: {
    ScoreEntry(date: .now, playerXScore: 5, losses: 3)
}

#Preview(as: .systemMedium) {
    GameWidget()
} timeline: {
    ScoreEntry(date: .now, playerXScore: 23, losses: 10)
}
