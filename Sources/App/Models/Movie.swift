import Fluent
import Vapor

final class Movie : Model, Content {
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String?
    
    @Field(key: "year")
    var year: String?
    
    @Field(key: "description")
    var description: String?

    init() { }

    init(id: UUID? = nil, title: String? ,year : String? , description : String?) {
        self.id = id
        self.title = title
        self.year = year
        self.description = description
    }
}
