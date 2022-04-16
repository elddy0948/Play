import UIKit
import CoreData

final class AllChampionViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private let coreDataStack = CoreDataStack(entityName: "LOLFavorite")
  
  var champions: [Champion] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    createChampions()
    
    setupTableView()
    
    let fetchRequest = NSFetchRequest<Champion>(entityName: "Champion")
    do {
      let results = try coreDataStack.managedObjectContext.fetch(fetchRequest)
      self.champions = results
      self.tableView.reloadData()
    } catch let error as NSError {
      print("Fetch error \(error), \(error.userInfo)")
    }
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension AllChampionViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return champions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "AllChampCell",
      for: indexPath) as? AllChampCell else {
      return UITableViewCell()
    }
    
    let champ = champions[indexPath.row]
    cell.configure(champ)
    
    return cell
  }
}

extension AllChampionViewController: UITableViewDelegate {
  
}


//MARK: - Helper Methods
extension AllChampionViewController {
  private func createChampions() {
    let missFortune = Champion(context: coreDataStack.managedObjectContext)
    missFortune.name = "Miss Fortune"
    missFortune.gender = "Female"
    missFortune.lane = "AD"
    
    let teemo = Champion(context: coreDataStack.managedObjectContext)
    teemo.name = "Teemo"
    teemo.gender = "Unknown"
    teemo.lane = "Top"
    
    let garen = Champion(context: coreDataStack.managedObjectContext)
    garen.name = "Garen"
    garen.gender = "Male"
    garen.lane = "Top"
    
    let graves = Champion(context: coreDataStack.managedObjectContext)
    graves.name = "Graves"
    graves.gender = "Male"
    graves.lane = "Jungle"
    
    let ezreal = Champion(context: coreDataStack.managedObjectContext)
    ezreal.name = "Ezreal"
    ezreal.gender = "Male"
    ezreal.lane = "AD"
    
    let blitzCrank = Champion(context: coreDataStack.managedObjectContext)
    blitzCrank.name = "Blitz Crank"
    blitzCrank.gender = "Unknown"
    blitzCrank.lane = "Support"
    
    coreDataStack.saveContext()
  }
}
