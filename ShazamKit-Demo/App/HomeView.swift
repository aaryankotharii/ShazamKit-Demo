//
//  ContentView.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var session: ShazamController

    var body: some View {
        NavigationView {
            ZStack {
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
                                Label("Star", systemImage: "star")
                            }
                            .tint(.orange)
                        }
                }
            }
            }
                VStack {
                    Spacer()
                    Button(action: session.listen) {
                        ShazamButton(title: $session.buttonTitle, state: $session.state)
                    }
                        .offset(x: 0, y: -50)
                }
            }
            .navigationBarTitle(Text("ShazamKit"))
            .searchable(text: $session.searchText)
        }
        .accentColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(session: ShazamController())
    }
}
