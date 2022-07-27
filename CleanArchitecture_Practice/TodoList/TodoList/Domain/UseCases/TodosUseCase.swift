import Foundation

public protocol TodosUseCase {
  func fetchAllTodos(completion: @escaping (Result<[Todo], Error>) -> Void)
  func save(todo: Todo, completion: @escaping (Result<Void, Error>) -> Void)
}
