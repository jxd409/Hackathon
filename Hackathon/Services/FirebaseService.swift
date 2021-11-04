import Combine
import Foundation
import FirebaseDatabase

class FirebaseService {

    // Injected
    let cache: Cache
    let logger: Logger

    var cancellable: AnyCancellable?

    init(cache: Cache = DIContainer.shared.resolve(),
         logger: Logger = DIContainer.shared.resolve()) {
        self.cache = cache
        self.logger = logger
    }

    func getData(from path: String) -> Future<Data, ServiceError> {
        let urlRequest = URLRequest(url: URL(string: path)!)

        return Future() { [weak self] promise in
            guard let self = self else {
                return promise(.failure(.systemFailure))
            }

            // return cached data if exists
            if let data: Data = try? self.cache.read(key: path) {
                self.logger.log("retrieving \(path) from cache")
                return promise(.success(data))
            }

            // else get data from service
            self.logger.log("retrieving \(path) from service")
            self.cancellable = URLSession.shared
                .dataTaskPublisher(for: urlRequest)
                .map { element in
                    element.data
                }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(_): return promise(.failure(ServiceError.unauthorized))
                    case .finished: break
                    }
                }, receiveValue: { data in
                    self.cache.add(data,
                                   forKey: path,
                                   expires: Date().addingTimeInterval(TimeInterval(Constants.Cache.userExpirationInSeconds)),
                                   persist: false)
                    return promise(.success(data))
                })
        }
    }

    func create<T: Identifiable & Codable>(object: T, for entity: String) -> String? {
        let database = Database.database().reference()
        let encoded = try? JSONSerialization.jsonObject(with: JSONEncoder().encode(object)) as? [String : Any]

        let child = database.child(EntityNames.hackathon)
            .child(entity)
            .child("\(object.id)")

        // writes to Firebase DB
        child.setValue(encoded)

        return child.key
    }

    func update<T: Identifiable & Codable>(object: T, for entity: String) {
        let database = Database.database().reference()
        let encoded = try? JSONSerialization.jsonObject(with: JSONEncoder().encode(object)) as? [String : Any]

        let child = database.child(EntityNames.hackathon)
            .child(entity)
            .child("\(object.id)")

        // writes to Firebase DB
        child.setValue(encoded)
    }
}

// Project
extension FirebaseService: CreateProjectUseCase, UpdateProjectUseCase {

    func getProjects() -> Future<Data, ServiceError> {
        getData(from: API.getProjects.path)
    }

    func createProject(project: Project) -> Project {
        let id = create(object: project, for: EntityNames.projects)

        var new = project
        new.id = id ?? ""
        return new
    }

    func updateProject(project: Project) {
        update(object: project, for: EntityNames.projects)
    }
}

// Contractor
extension FirebaseService: CreateContractorUseCase, UpdateContractorUseCase {
    func getContractors() -> Future<Data, ServiceError> {
        getData(from: API.getContractors.path)
    }

    func createContractor(contractor: Contractor) -> Contractor {
        let id = create(object: contractor, for: EntityNames.contractors)

        var new = contractor
        new.id = id ?? ""
        return new
    }

    func updateContractor(contractor: Contractor) {
        update(object: contractor, for: EntityNames.contractors)
    }
}

// Customer
extension FirebaseService: CreateCustomerUseCase, UpdateCustomerUseCase {
    func getCustomers() -> Future<Data, ServiceError> {
        getData(from: API.getCustomers.path)
    }

    func createCustomer() -> Customer {
        let customer = Customer(projectIds: [])
        let id = create(object: customer, for: EntityNames.customers)

        var new = customer
        new.id = id ?? ""
        return new
    }

    func updateCustomer(customer: Customer) {
        update(object: customer, for: EntityNames.customers)
    }
}

// Project State
extension FirebaseService: CreateProjectStateUseCase, UpdateProjectStateUseCase {
    func getProjectStates() -> Future<Data, ServiceError> {
        getData(from: API.getProjectStates.path)
    }

    func createProjectState(projectState: ProjectState) -> ProjectState {
        let id = create(object: projectState, for: EntityNames.projectStates)

        var new = projectState
        new.id = id ?? ""
        return new
    }

    func updateProjectState(projectState: ProjectState) {
        update(object: projectState, for: EntityNames.projectStates)
    }
}

extension FirebaseService {
    struct EntityNames {
        static let hackathon = "Hackathon"
        static let projects = "Projects"
        static let contractors = "Contractors"
        static let customers = "Customers"
        static let projectStates = "ProjectStates"
    }
}

extension FirebaseService {
    enum API {
        case getProjects
        case getCustomers
        case getContractors
        case getProjectStates

        var path: String {
            switch self {
            case .getProjects: return "\(SWEnvironment.default.firebaseAPI)/\(EntityNames.projects).json"
            case .getCustomers: return "\(SWEnvironment.default.firebaseAPI)/\(EntityNames.customers).json"
            case .getContractors: return "\(SWEnvironment.default.firebaseAPI)/\(EntityNames.contractors).json"
            case .getProjectStates: return "\(SWEnvironment.default.firebaseAPI)/\(EntityNames.projectStates).json"
            }
        }
    }
}
