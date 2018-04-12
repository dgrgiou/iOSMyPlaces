//
//  Places.swift
//  iOSMyPlaces
//
//  Created by Dimitrios Georgiou on 4/4/18.
//  Copyright © 2018 Dimitrios Georgiou. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Places : NSObject, MKAnnotation{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(json: [Any]) {
        
        //Get places info from json
        if let title = json[0] as? String {
            self.title = title
        } else {
            self.title = "No Title"
        }
        self.locationName = json[1] as! String
        self.discipline = json[4] as! String
        
        //Get coords
        if let latitude = Double(json[2] as! String),
            let longitude = Double(json[3] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String? {
        return locationName
    }
    
    // pinTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch discipline {
        case "Plaque":
            return .blue
        case "GazStation":
            return .purple
        default:
            return .green
        }
    }
    
    var imageName: String? {
        if (discipline == "Sculpture")
        {
            return "Statue"
            
        }
        else if(discipline == "GazStation")
        {
            return "GasStation"
        }
        else
        {
            return "Flag"
        }
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
