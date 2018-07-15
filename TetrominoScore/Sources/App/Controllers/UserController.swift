//import Vapor
//import Authentication
//
//final class UserController {
//
//    func index(_ req: Request) throws -> EventLoopFuture<[User]> {
//        return User.query(on: req).all()
//    }
//
//    func createUser(_ request: Request) throws -> EventLoopFuture<User.AuthenticatedUser> {
//        return try request.content.decode(User.self).flatMap { (user) -> EventLoopFuture<User.AuthenticatedUser> in
//            let hasher = try request.make(BCryptDigest.self)
//            let passwordHashed = try hasher.hash(user.password)
//            let newUser = User(email: user.email, password: passwordHashed)
//            return newUser.save(on: request).map({ (authedUser) -> (User.AuthenticatedUser) in
//                return try User.AuthenticatedUser(email: authedUser.email, id: authedUser.requireID())
//            })
//        }
//    }
//}
