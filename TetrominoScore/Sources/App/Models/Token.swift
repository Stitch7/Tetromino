import Authentication

let token = Token(key: "secretToken123")

struct Token {
    let key: String
}

extension Token {
    init(bearer: BearerAuthorization) {
        self.key = bearer.token
    }
}

extension Token: Equatable {
    static func == (lhs: Token, rhs: Token) -> Bool {
        return lhs.key == rhs.key
    }

    static func == (lhs: Token, rhs: BearerAuthorization) -> Bool {
        return lhs == Token(bearer: rhs)
    }

    static func == (lhs: BearerAuthorization, rhs: Token) -> Bool {
        return rhs == lhs
    }
}

extension Token: BearerAuthenticatable {

    static var tokenKey: WritableKeyPath<Token, String> { return \Token.key as! WritableKeyPath<Token, String> }

    static func authenticate(using bearer: BearerAuthorization, on connection: DatabaseConnectable) -> EventLoopFuture<Token?> {
        return connection.eventLoop.submit({ () -> Token? in
            return token == bearer ? token : nil
        })
    }
}
