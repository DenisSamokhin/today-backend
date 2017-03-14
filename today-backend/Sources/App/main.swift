import Vapor
import Foundation

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("info") { req in
    let date = Date()
    let calendar = Calendar.current
    
    let hours = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    
    return try JSON(node: [
        "place"     : "habrahabr",
        "framework" : "vapor",
        "time"      : "\(hours):\(minutes):\(seconds)"
        ])
}

drop.resource("posts", PostController())

drop.run()
