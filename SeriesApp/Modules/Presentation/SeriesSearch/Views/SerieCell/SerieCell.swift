//
//  SerieCell.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit
import SDWebImage

class SerieCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    //MARK: Properties
    static let identifier = "SerieCell"
    
    func configure(using serie: Serie) {
        titleLabel.text = serie.title
        subtitleLabel.text = serie.subtitle
        previewImageView.sd_setImage(
            with: URL(string: Constants.serverBaseUrl + serie.previewImageURL),
            placeholderImage: UIImage(named: "placeholder"),
            options: .progressiveLoad,
            context: nil
        )
    }
}
