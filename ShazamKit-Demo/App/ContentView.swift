//
//  ContentView.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var session: ShazamController

    var body: some View {
        NavigationView {
            VStack {
                List {
                ForEach(session.searchResults,id:\.title) { media in
                    NavigationLink(destination: ShazamDetail(media: SHMedia(media: media))) {
                    ShazamRow(media: SHMedia(media: media))
                    }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                session.delete(media)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            Button { } label: {
                                Label("Flag", systemImage: "flag")
                            }
                            .tint(.orange)
                        }
                }
            }
                Button("Listen",action: session.listen)
            }
            .navigationBarTitle(Text("ShazamKit"))
            .searchable(text: $session.searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(session: ShazamController())
    }
}
