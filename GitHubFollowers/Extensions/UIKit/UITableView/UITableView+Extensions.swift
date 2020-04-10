//
//  UITableView+Extensions.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

typealias UITableViewDelegateAndDataSource = UITableViewDelegate & UITableViewDataSource

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>(cellClass: Cell.Type) -> Cell {
        let identifier = String(describing: cellClass.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func initialize<Cell: UITableViewCell>(cellClass: Cell.Type, id: String, rowHeight: CGFloat, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        register(cellClass, forCellReuseIdentifier: id)
        self.dataSource = dataSource
        self.delegate = delegate
        self.rowHeight = rowHeight
        tableFooterView = UIView(frame: .zero)
    }
}

