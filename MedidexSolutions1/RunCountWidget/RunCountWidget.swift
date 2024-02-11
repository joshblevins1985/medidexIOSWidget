//
//  RunCountWidget.swift
//  RunCountWidget
//
//  Created by EMT OH on 12/31/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct RunCountWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                HStack{
                    VStack{
                        

                        Text("Today")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack{
                        
                        Text("Lost")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack{
                        
                        Text("Canceled")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
         
                }
            }
            
            Spacer()
            
            VStack{
                Text("0")
                    .font(.system(size: 60))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                
                Text("This Month")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            
            
        }
        .padding()
    }
}

struct RunCountWidget: Widget {
    let kind: String = "RunCountWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                RunCountWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RunCountWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    RunCountWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
