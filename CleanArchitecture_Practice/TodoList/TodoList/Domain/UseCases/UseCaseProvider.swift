public protocol UseCaseProvider {
  func makeTodosUseCase() -> TodosUseCase
}
