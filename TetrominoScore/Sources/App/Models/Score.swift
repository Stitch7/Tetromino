import FluentSQLite
import Vapor

final class Score: SQLiteModel {

    var id: Int?
    var username: String
    var system: String
    var value: Int
    var date: Date?
    

    init(id: Int? = nil, username: String, system: String, value: Int) {
        self.id = id
        self.username = username
        self.system = system
        self.value = value
        self.date = Date()
    }

    func willCreate(on connection: SQLiteConnection) throws -> Future<Score> {
        /// TODO: Throw an error if the username is invalid

        self.date = Date()

        /// Return the user. No async work is being done, so we must create a future manually.
        return Future.map(on: connection) { self }
    }
}

extension Score: Content {}
extension Score: Migration {}
