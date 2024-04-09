import Fluent

struct MoviesAM : AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("movies")
            .id()
            .field("title", .string)
            .field("year", .string)
            .field("description", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("movies").delete()
    }
}
