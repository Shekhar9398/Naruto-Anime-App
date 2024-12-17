
import UIKit
import SDWebImage

class TailBeastsVC: UIViewController {
    
    @IBOutlet weak var tailBeastTable: UITableView!
    
    let viewModel = TailBeastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        getTailBeasts()
        
        tailBeastTable.register(TailBeastCell.nib(), forCellReuseIdentifier: TailBeastCell.identifier)
        tailBeastTable.delegate = self
        tailBeastTable.dataSource = self
    }
    
    private func getTailBeasts() {
           viewModel.fetchTailBeasts { [weak self] result in
               guard let self = self else { return }
               DispatchQueue.main.async {
                   switch result {
                   case .success(let beasts):
                       print("TailBeasts Fetched Successfully: \(beasts)")
                       self.tailBeastTable.reloadData()
                   case .failure(let error):
                       print("Error while fetching TailBeasts: \(error)")
                   }
               }
           }
       }
    
}

extension TailBeastsVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tailBeasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tailBeastTable.dequeueReusableCell(withIdentifier: TailBeastCell.identifier, for: indexPath) as! TailBeastCell
        
        let imageStringArr = viewModel.tailBeasts[indexPath.row].images
        
        for imageString in imageStringArr {
            cell.tailBeastImage.sd_setImage(with: URL(string: imageString))
        }
        
        // Make the image circular
        cell.tailBeastImage.layer.cornerRadius = cell.tailBeastImage.frame.size.width / 2
        cell.tailBeastImage.clipsToBounds = true

        // Add a circular border (stroke) around the image
        cell.tailBeastImage.layer.borderWidth = 5.0
        cell.tailBeastImage.layer.borderColor = UIColor.orange.cgColor
        
        cell.halfBottomJoinImage.image = UIImage(named: "shape")
        cell.halftTopJoinImage.image = UIImage(named: "shape")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
}
