//
//  Protocols.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

protocol CollectionViewAdapter: UICollectionViewDataSource , UICollectionViewDelegate  { }

