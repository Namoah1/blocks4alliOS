//
//  bottomFlowLayout.swift
//  BlocksForAll
//
//  Created by Lauren Milne on 4/26/17.
//  Copyright © 2017 Lauren Milne. All rights reserved.
//

import UIKit

class BottomLayout: UICollectionViewLayout {
    
    //cache attributes so they do not need to be recalculated
    /*private var layoutAttributes = [UICollectionViewlayoutAttributes]()
    var blockWidth = 100
    var
    
    
    
    override func prepare(){
        
    }
     let cellSpacing:CGFloat = 0
     
     override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
     if let attributes = super.layoutAttributesForElements(in: rect) {
     for (index, attribute) in attributes.enumerated() {
     if index == 0 { continue }
     let prevLayoutAttributes = attributes[index - 1]
     let origin = prevLayoutAttributes.frame.maxX
     if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width){
     attribute.frame.origin.x = origin + cellSpacing
     }//self.collectionViewContentSize().width) {
     }
     return attributes
     }
     return nil
     }
     */

}
