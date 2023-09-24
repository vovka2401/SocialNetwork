import Firebase

class FirebaseManager: NSObject {
    static let shared = FirebaseManager()
    let auth: Auth
    let storage: Storage

    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        super.init()
    }
}
