//
//  LocationCollectionViewDataSource.swift
//  Say Their Names
//
//  Created by JohnAnthony on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class LocationCollectionViewDataSource: NSObject {
     
    var locations: [Location]
    
    init(locations: [Location]) {
        self.locations = locations
    }
    
    func setLocations(_ locations: [Location]) {
        self.locations = locations
    }
    
    func numberOfItems() -> Int {
        return locations.count
    }
    
}


extension LocationCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let location = locations[indexPath.item]
        
        if let locationCell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.locationIdentifier, for: indexPath) as? LocationCell {
            locationCell.configure(with: location)
            return locationCell
        }
        
        return UICollectionViewCell()
    }
}
