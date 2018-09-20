import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()



public class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        
        router.get("/") { request, response, next in
            response.send("Hello, World!")
            next()
        }
        
        router.get("/framework", handler: frameworkHandler)
        router.get("/benchmark", handler: benchmarkHandler)
    }
    
    func frameworkHandler(completion: (Dictionary<String, String>?, RequestError?) -> Void ) {
        completion(["hello": "world"], nil)
    }
    
    func benchmarkHandler(completion: (Dictionary<String, Array<String>>?, RequestError?) -> Void ) {
        var content = [String]()
        
        for i in 0...10000 {
            let value = String(format:  "Index %d", i)
            content.append(value)
        }
        completion(["results": Array(content.prefix(10))], nil)
    }
    
    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
