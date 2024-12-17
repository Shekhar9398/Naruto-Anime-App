
import UIKit

class AkatsukiCell: UITableViewCell {

    @IBOutlet weak var akatsukiImage: UIImageView!
    @IBOutlet weak var akatsukiName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "AkatsukiCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AkatsukiCell", bundle: nil)
    }
}
