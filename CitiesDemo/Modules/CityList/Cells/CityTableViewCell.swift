//
//  CityTableViewCell.swift
//  CitiesDemo
//
//  Created by Geddawy on 19/08/2022.
//

import UIKit
import SDWebImage

class CityTableViewCell: UITableViewCell {
    static let ID = "CityTableViewCell"
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: City){
        self.cityLabel.text = "City: \(model.name ?? "")"
        self.countryCodeLabel.text = "County Code: \(model.country ?? "")"
        self.bindImage(lat: model.coord?.lat ?? "", lon: model.coord?.lon ?? "")
    }
    
    private func bindImage(lat: String, lon: String){
        let url = "https://maps.googleapis.com/maps/api/staticmap?center=\(lat),\(lon)&zoom=12&size=400x100&key=\(GoogleAPIKey.Key)&format=png"
        mapImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
    }
    
}
