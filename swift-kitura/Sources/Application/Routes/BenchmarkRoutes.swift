import Foundation
import KituraContracts

func initializeBenchmarkRoutes(app: App) {
    app.router.get("/benchmark", handler: benchmarkHandler)
}

func benchmarkHandler(completion: (Dictionary<String, Array<String>>?, RequestError?) -> Void) {
    var content = [String]()

    for i in 0...10000 {
        let value = String(format: "Index %d", i)
        content.append(value)
    }
    completion(["results": Array(content.prefix(10))], nil)
}
