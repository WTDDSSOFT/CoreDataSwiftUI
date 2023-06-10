//
//  ContentView.swift
//  HelloCoreData
//
//  Created by william torres dias dos santos on 16/12/22.
//

import SwiftUI

struct ContentView: View {

   let coreDM: CoreDataManager

   @State private var movieName: String  = ""
   @State private var movies: [Movie] = [Movie]()
   @State private var needsRefresh: Bool = false

   private func populateMovies() {
      movies = coreDM.getAllMovies()
   }

   var body: some View {
      NavigationView {

         VStack {
            TextField("Enter movie name", text:$movieName)
               .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
               coreDM.saveMovie(title: movieName)
               populateMovies()
            }

            List {
               ForEach(movies, id: \.self) { movie in
                    NavigationLink(
                     destination: MovieDetail(
                        movie: movie,
                        coreDM: coreDM,
                        needsRefresh: $needsRefresh
                     ),
                       label: {
                          Text(movie.title ?? "")
                       }
                    )
               }.onDelete { indexSet in
                  indexSet.forEach { index in
                     let movie = movies[index]
                     coreDM.deleteMovie(movie: movie)
                     populateMovies()
                  }
               }
            }// List
            .listStyle(PlainListStyle())
            .accentColor(needsRefresh ? .white: .black)

            Spacer()

         }// VStack
         .padding()
         .onAppear {
            populateMovies()
         }
      }// NavigationView

   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      ContentView(coreDM: CoreDataManager())
   }
}
