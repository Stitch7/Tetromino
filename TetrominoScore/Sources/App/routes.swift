import Vapor
import Leaf
import Authentication

public func routes(_ router: Router) throws {
//    let userController = UserController()
    let scoreController = ScoreController()

//    router.post("createUser", use: userController.createUser)




    let bearerAuthMiddleware = BearerAuthenticationMiddleware<Token>()
    let bearerAuthGuardMiddleware = Token.guardAuthMiddleware()

//    let basicAuthMiddleware = BasicAuthenticationMiddleware<User>(verifier: BCryptDigest())
//    let basicAuthGuardMiddleware = User.guardAuthMiddleware()


    let maniacAuthMiddleware = ManiacAuthenticationMiddleware()
//    let maniacAuthGuardMiddleware = User.guardAuthMiddleware()


    let authGroup = router.grouped([bearerAuthMiddleware,bearerAuthGuardMiddleware,
//                                    basicAuthMiddleware, basicAuthGuardMiddleware,
                                    maniacAuthMiddleware,
                                    //maniacAuthGuardMiddleware
                                    ])
//    let authedGroup = router.grouped(authMiddleWare)

//    authGroup.get("users", use: userController.index)

    authGroup.get("/", use: scoreController.index)
    authGroup.post("/", use: scoreController.create)
    authGroup.get("html", use: scoreController.html)
}
