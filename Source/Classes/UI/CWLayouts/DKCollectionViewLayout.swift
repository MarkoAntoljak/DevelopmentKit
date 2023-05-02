//
//  DKCollectionViewLayout.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import UIKit

/// Custom collection view horizontal layout.
open class DKCollectionViewLayoutHorizontal: UICollectionViewCompositionalLayout {
    
    public init(withHeader: Bool = false,
                numOfItemsInRow: CGFloat,
                itemHeight: NSCollectionLayoutDimension = .absolute(150),
                itemWidth: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                spacing: CGFloat = 5.0) {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/numOfItemsInRow),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        if withHeader {
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
            
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [headerElement]
        }
        
        super.init(section: section)
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
}
