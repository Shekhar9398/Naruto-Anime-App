
import UIKit

class TailBeastCell: UITableViewCell {

    @IBOutlet weak var tailBeastImage: UIImageView!
    @IBOutlet weak var halfBottomJoinImage: UIImageView!
    @IBOutlet weak var halftTopJoinImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "TailBeastCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "TailBeastCell", bundle: nil)
    }
}
