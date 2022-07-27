import Foundation

public protocol TodosUseCase {
  func fetchAllTodos(completion: @escaping (Result<[DomainTodo], Error>) -> Void)
  func save(todo: DomainTodo, completion: @escaping (Result<Void, Error>) -> Void)
}
