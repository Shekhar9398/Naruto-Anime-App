import UIKit
import SDWebImage

class AkatsukiVC: UIViewController {
    
    @IBOutlet weak var akatsukiTable: UITableView!
    
    let viewModel = AkatsukiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        akatsukiTable.delegate = self
        akatsukiTable.dataSource = self
        akatsukiTable.register(AkatsukiCell.nib(), forCellReuseIdentifier: AkatsukiCell.identifier)
    }
    
    private func fetchData() {
        viewModel.fetchAkatsuki()
        viewModel.onFetchComplete = { [weak self] in
            DispatchQueue.main.async {
                self?.akatsukiTable.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension AkatsukiVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.akatsukiNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AkatsukiCell.identifier, for: indexPath) as? AkatsukiCell else {
            return UITableViewCell()
        }
        
        // Set character name
        cell.akatsukiName.text = viewModel.akatsukiNames[indexPath.row]
        
        // Set character image (only the first image)
        if let imageStr = viewModel.akatsukiImages[indexPath.row].first,
           let imageUrl = URL(string: imageStr) {
            cell.akatsukiImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            cell.akatsukiImage.image = UIImage(named: "placeholder")
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

// MARK: - UITableViewDelegate
extension AkatsukiVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected character")
    }
}
