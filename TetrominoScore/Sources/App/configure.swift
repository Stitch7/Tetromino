import Vapor
import Leaf
import FluentSQLite
import Authentication

// Called before your application initializes.
public func configure(_ config: inout Config,
                      _ env: inout Environment,
                      _ services: inout Services) throws {

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    let myService = NIOServerConfig.default(port: 8002)
    services.register(myService)

    try services.register(LeafProvider())
    try services.register(FluentSQLiteProvider())
    try services.register(AuthenticationProvider())

    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    let databaseFile = SQLiteStorage.file(path: "database.sqlite")

    var databases = DatabasesConfig()
    try databases.add(database: SQLiteDatabase(storage: databaseFile), as: .sqlite)
    services.register(databases)

    var migrations = MigrationConfig()
//    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: Score.self, database: .sqlite)
    services.register(migrations)
}
