

import UIKit
import Alamofire

class RowsCell : UITableViewCell {
    
    lazy var listViewModel: ListViewModel  = {
        return ListViewModel()
    }()
    let minValue = 0
    
    var row : Rows? {
        didSet {
            let imageCompletionClosure = { [unowned self] ( imageData: NSData ) -> Void in
                // Download occurs on background thread, but UI update
                // MUST occur on the main thread.
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0, animations: {
                        self.productImage.image = UIImage(data: imageData as Data)
                    })
                } // end DispatchQueue.main.async
                
            } // end let imageCompletionClosure...
            if let url =  row?.imageHref {
                listViewModel.downloadImg(imgurl:url, completionHanlder: imageCompletionClosure)
            }
            productNameLabel.text = row?.title
            productDescriptionLabel.text = row?.description
        }
    }
    
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
       // lbl.sizeToFit()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let productImage : UIImageView = {
        //let imgView = UIImageView(image: #imageLiteral(resourceName: "glasses"))
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImage)
        addSubview(productNameLabel)
        addSubview(productDescriptionLabel)
                
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        productNameLabel.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width , height: 0, enableInsets: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
