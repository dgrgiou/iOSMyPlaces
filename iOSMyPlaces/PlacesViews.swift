//
//  PlacesViews.swift
//  
//
//  Created by Dimitrios Georgiou on 4/4/18.
//

import Foundation
import MapKit

class PlacesMarkerView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let places = newValue as? Places else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = places.markerTintColor
            if let imageName = places.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
}

class PlacesView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let places = newValue as? Places else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            //      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let imageName = places.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = places.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
