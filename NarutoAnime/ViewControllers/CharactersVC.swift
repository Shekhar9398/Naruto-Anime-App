import UIKit
import SDWebImage

class CharactersVC: UIViewController {
    
    @IBOutlet weak var characterTable: UITableView!
    
    let viewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        characterTable.delegate = self
        characterTable.dataSource = self
        characterTable.register(CharacterCell.nib(), forCellReuseIdentifier: CharacterCell.identifier)
    }
    
    private func fetchData() {
        viewModel.fetchCharacters()
        viewModel.onFetchComplete = { [weak self] in
            DispatchQueue.main.async {
                self?.characterTable.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CharactersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        
        // Set character name
        cell.characterName?.text = viewModel.characterNames[indexPath.row]
        
        // Set character image (only the first image)
        if let imageStr = viewModel.characterImages[indexPath.row].first,
           let imageUrl = URL(string: imageStr) {
            cell.characterImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.characterImage.image = UIImage(named: "placeholder")
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

// MARK: - UITableViewDelegate
extension CharactersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected character: \(viewModel.characterNames[indexPath.row])")
    }
}
