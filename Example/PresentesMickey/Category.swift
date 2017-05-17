struct Category {

    typealias Json = [String: Any]

    let id: Int?
    let name: String?

    init?(json: Json) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
    }

}
