//
//  ContentView.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct HomeView: View {
    // MARK: PROPERTIES
    @ObservedObject var session: ShazamController
    
    // MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(session.searchResults,id:\.title) { media in
                            NavigationLink(destination: ShazamDetail(media: SHMedia(media: media))) {
                                ShazamRow(media: SHMedia(media: media))
                            } // NAVIGTAION LINK
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
                            } // SWIPE
                        } // FOREACH
                    } // LIST
                } // VSTACK I
                VStack {
                    Spacer()
                    Button(action: session.listen) {
                        ShazamButton(title: $session.buttonTitle, state: $session.state)
                    }
                    .offset(x: 0, y: -50)
                } // VSTACK II
            } // ZTSACK
            .navigationBarTitle(Text("ShazamKit"))
            .searchable(text: $session.searchText)
        } // NAVIGATION
        .accentColor(.white)
    } // BODY
}

// MARK: PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(session: ShazamController())
    }
}
