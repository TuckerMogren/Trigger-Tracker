import UIKit
class CustomTableViewCell: UITableViewCell {
    
    var message : String?
    var mainImage : UIImage?
    
    
    //look into changing this to a label
    var messageView : UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = textView.font.withSize(24)
        textView.numberOfLines = 10
        
        
        return textView
    }()
    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true//issue with this constraint
        mainImageView.bottomAnchor.constraint(equalTo: self.messageView.topAnchor).isActive = true
        
        mainImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        messageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let message = message {
            messageView.text = message
        }
        
        if let image = mainImage {
            mainImageView.image = image
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
