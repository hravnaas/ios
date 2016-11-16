//
//  LocationCellTableViewCell.swift
//  MyLocations
//
//  Created by Hans Ravnaas on 11/15/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
	}
	
	func configure(for location: MyLocation)
	{
		if location.locationDescription.isEmpty {
			descriptionLabel.text = "(No Description)"
		} else {
			descriptionLabel.text = location.locationDescription
		}
		
		if let placemark = location.placemark {
			var text = ""
			if let s = placemark.subThoroughfare {
				text += s + " " }
			
			if let s = placemark.thoroughfare {
				text += s + ", "
			}
			
			if let s = placemark.locality {
				text += s }
				addressLabel.text = text
			} else {
				addressLabel.text = String(format: "Lat: %.8f, Long: %.8f", location.latitude, location.longitude)
			}
	}
}
