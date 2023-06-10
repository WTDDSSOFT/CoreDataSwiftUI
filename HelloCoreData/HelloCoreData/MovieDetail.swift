//
//  MovieDetail.swift
//  HelloCoreData
//
//  Created by william torres dias dos santos on 18/12/22.
//

import SwiftUI

struct MovieDetail: View {

   let movie: Movie
   let coreDM: CoreDataManager

   @State private var movieName: String = ""
   @Binding var needsRefresh: Bool

    var body: some View {

       VStack {

          TextField(movie.title ?? "", text: $movieName)
             .textFieldStyle(RoundedBorderTextFieldStyle())
          Button("Update") {
              if !movieName.isEmpty {
                 movie.title = movieName
                 coreDM.updateMovie()
                 needsRefresh.toggle()
              }
          }
          
       }.padding()

    }
}

struct MovieDetail_Previews: PreviewProvider {

    static var previews: some View {

       let coreDm  = CoreDataManager()
       let movie = Movie(context: coreDm.persistContainer.viewContext)

       MovieDetail(movie: movie, coreDM: coreDm, needsRefresh: .constant(false))
    }

}
