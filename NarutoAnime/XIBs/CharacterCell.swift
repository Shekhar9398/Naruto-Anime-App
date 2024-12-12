
import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "CharacterCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CharacterCell", bundle: nil)
    }
    
    
}
