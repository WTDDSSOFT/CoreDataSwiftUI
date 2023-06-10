//
//  CoreDataManager.swift
//  HelloCoreData
//
//  Created by william torres dias dos santos on 16/12/22.
//

import Foundation
import CoreData

class CoreDataManager {

   let persistContainer: NSPersistentContainer // initializer coreData

   init() {
      persistContainer = NSPersistentContainer(name: "HelloCoreDataModel")
      persistContainer.loadPersistentStores { description, error in

         if let error = error {
            fatalError("Core Data Store falied to initialize \(error.localizedDescription)")
         }
      }
   }

   func updateMovie() {
      do {
         try persistContainer.viewContext.save()
      } catch {
         persistContainer.viewContext.rollback()
      }
   }

   func deleteMovie(movie: Movie) {
      persistContainer.viewContext.delete(movie)

      do {
         try persistContainer.viewContext.save()
      } catch {
         persistContainer.viewContext.rollback()
         print("Falid to save context \(error.localizedDescription)")
      }
   }

   func getAllMovies() -> [Movie] {
      let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()

      do {
         return try persistContainer.viewContext.fetch(fetchRequest)
      } catch {
         return []
      }
   }

   func saveMovie(title: String) {

      let movie = Movie(context: persistContainer.viewContext)
      movie.title = title

      do {
         try persistContainer.viewContext.save()
         print("Moview save")
      } catch {
         print("Falid to save movie \(error)")
      }
   }
}
