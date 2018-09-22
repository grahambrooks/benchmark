import Foundation
import KituraContracts

func initializeFrameworkRoutes(app: App) {
    app.router.get("/framework", handler: frameworkHandler)
}
func frameworkHandler(completion: (Dictionary<String, String>?, RequestError?) -> Void) {
    completion(["hello": "world"], nil)
}
