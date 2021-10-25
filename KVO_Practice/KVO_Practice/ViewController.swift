import UIKit

class ViewController: UITableViewController {
  
  var observableLineup: Any?
  var playerService = PlayerService()
  var lineup: [Player] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    observableLineup = playerService.observe(\PlayerService.lineup,
                                             options: [.initial, .new]) { [weak self] playerService, change in
      guard let self = self else { return }
      self.lineup = playerService.lineup
      self.tableView.reloadData()
    }
  }
  
  private func configure() {
    title = "Today's Chelsea Best 11"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.tableFooterView = UIView()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchTodayLineup))
  }
  
  @objc func fetchTodayLineup() {
    playerService.fetchLineup()
  }
}


extension ViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lineup.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let player = lineup[indexPath.row]
    
    switch player.position {
    case "ST":
      cell.backgroundColor = .systemRed
    case "MF":
      cell.backgroundColor = .systemGreen
    case "DF":
      cell.backgroundColor = .systemBlue
    case "GK":
      cell.backgroundColor = .systemYellow
    default:
      cell.backgroundColor = .systemBackground
    }
    
    cell.textLabel?.text = "\(player.number). \(player.name)"
    return cell
  }
}
