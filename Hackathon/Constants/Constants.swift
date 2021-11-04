struct Constants {

    struct Build {
        static let app = SWApplication.colorSnap
    }

    struct FirebaseAPI {
        static let QA = "https://sw-probuy-debug.firebaseio.com/Hackathon"
        static let PRODUCTION = "https://sw-probuy-debug.firebaseio.com/Hackathon"
    }

    struct Cache {
        static let userExpirationInSeconds = 10 // 10 seconds
    }

    struct Preferences {
        static let contractorId = "contractorId"
    }
}
