import Vapor

final class ScoreController {
    func index(_ req: Request) throws -> EventLoopFuture<[Score]> {
        return Score.query(on: req).all()
    }

    func create(_ req: Request) throws -> EventLoopFuture<Score> {
        return try req.content.decode(Score.self).flatMap { score in
//            let user = try req.requireAuthenticated(User.self)

            let username = req.http.headers.basicAuthorization?.username

            return score.save(on: req)
        }
    }

    func html(_ req: Request) throws -> EventLoopFuture<View> {
        return Score.query(on: req).all().flatMap { scores in
            let data = ["scores": scores]
            return try req.view().render("scores", data)
        }
    }
}
