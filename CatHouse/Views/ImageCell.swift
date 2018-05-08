import SnapKit
import UIKit


class ImageCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var activitIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        self.activitIndicator.isHidden = false
        self.addSubview(activitIndicator)
        activitIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        self.activitIndicator.isHidden = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
