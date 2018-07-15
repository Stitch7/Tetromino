import Authentication

public final class ManiacAuthenticationMiddleware: Middleware {

    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {

        print("------------------------------------------")
        let username = try req.content.syncGet(String.self, at: "username")
        let password = try req.content.syncGet(String.self, at: "password")
        print("username: \(username)")
        print("password: \(password)")
        print("------------------------------------------")

//        let loginUrl = "https://nerds.berlin/mservice/test-login"
//
//        let httpRes = HTTPClient.connect(hostname: "nerds.berlin", on: req.privateContainer).map(to: HTTPResponse.self) { client in
//            var httpReq = HTTPRequest(method: .GET, url: loginUrl)
//            httpReq.headers.basicAuthorization = BasicAuthorization(username: username, password: password)
//            return client.send(httpReq).flatMap(to: Future<Response>, { (respi) -> EventLoopFuture<HTTPResponse> in
//                <#code#>
//            })
//        }
//
//        return httpRes

        if try verifyManiacCredentials(username: username, password: password) {
            return try next.respond(to: req)
        } else {
            throw Abort(.unauthorized, reason: "User not a maniac.")
        }
    }

    private func verifyManiacCredentials(username: String, password: String) throws -> Bool {
        let loginUrl = "https://nerds.berlin/mservice/test-login"

        let worker = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let client = try HTTPClient.connect(hostname: "nerds.berlin", on: worker).wait()

        var httpReq = HTTPRequest(method: .GET, url: loginUrl)
        httpReq.headers.basicAuthorization = BasicAuthorization(username: username, password: password)

        let response = try client.send(httpReq).wait()

        return response.status == .ok
    }
}
