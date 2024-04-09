import Fluent
import Vapor


struct MovieController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let movies = routes.grouped("movies")
        movies.post( "addMovie" , use : createMovie)
        movies.post( "deleteMovie" , use: delete )
        movies.get( "getMovies" , use: getAll )
        movies.post("updateMovie", use: update)
        
    }
    
    func getAll(req: Request) async throws -> [Movie] {
        return try await Movie.query(on: req.db).all()
    }
    
    func  createMovie(req: Request) async throws -> String {
        let movie = try req.content.decode(Movie.self)
        
        try await movie.save(on: req.db)
        
        return " Success "
    }
    
   
    
    
    func delete( req: Request) async throws -> String {
        let title = try req.content.decode(Movie.self).title
        
        if let movie = try await Movie.query(on: req.db).filter(\.$title == title).first()
        {
            try await movie.delete(on: req.db)
            return " Success "
        }
        
        return "Fail"
    }
    
    func update( req: Request) async throws -> Movie {
        
        let newMovie = try req.content.decode(Movie.self)
        if let movie = try await Movie.query(on: req.db).filter(\.$title == newMovie.title).first()
        {
            movie.title = newMovie.title
            movie.year = newMovie.year
            movie.description = newMovie.description
            
            try await movie.update(on: req.db)
            return  movie
        }
        
        throw Abort(.notFound)
     
    }

   

    
}
