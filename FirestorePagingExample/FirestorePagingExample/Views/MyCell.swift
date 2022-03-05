import UIKit

final class MyCell: UITableViewCell {
  static let reuseIdentifier = String(describing: MyCell.self)
  
  //MARK: - Views
  private let stackView = UIStackView()
  private let numberLabel = UILabel()
  private let greetingLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupStackView()
    setupNumberLabel()
    setupGreetingLabel()
    
    layout()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func configureCellData(with cellModel: CellModel) {
    numberLabel.text = "Cell No.\(cellModel.number)"
    greetingLabel.text = cellModel.greeting
  }
}

//MARK: - UI Setup / Layout
extension MyCell {
  private func setupStackView() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.backgroundColor = .systemBackground
  }
  
  private func setupNumberLabel() {
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.font = .preferredFont(forTextStyle: .body)
    numberLabel.textColor = .label
    numberLabel.numberOfLines = 0
  }
  
  private func setupGreetingLabel() {
    greetingLabel.translatesAutoresizingMaskIntoConstraints = false
    greetingLabel.font = .preferredFont(forTextStyle: .body)
    greetingLabel.textColor = .label
    greetingLabel.numberOfLines = 0
  }
  
  private func layout() {
    stackView.addArrangedSubview(numberLabel)
    stackView.addArrangedSubview(greetingLabel)
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor,
                                     multiplier: 1),
      stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor,
                                         multiplier: 1),
      contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor,
                                            multiplier: 1),
      contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor,
                                     multiplier: 1),
    ])
  }
}
