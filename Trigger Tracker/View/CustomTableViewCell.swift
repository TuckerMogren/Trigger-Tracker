import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellOneImageView: UIImageView!
    @IBOutlet weak var cellOneNotesLabelView: UILabel!
    @IBOutlet weak var cellOneDateLabelView: UILabel!
    @IBOutlet weak var cellOneProgressView: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
