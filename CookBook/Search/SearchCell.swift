//
//  SearchCell.swift
//  CookBook
//
//  Created by vasily on 04.12.2022.
//

import UIKit

class SearchCell: UITableViewCell {
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLbl)
        
        titleLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
