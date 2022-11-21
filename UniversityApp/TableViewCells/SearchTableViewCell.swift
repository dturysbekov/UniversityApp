//
//  SearchTableViewCell.swift
//  UniversityApp
//
//  Created by darkhan on 15.11.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        return name
    }()
    
    lazy var imageTap: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageTap)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(10)
        }
        
        imageTap.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
    
    func setAddedState(_ state: Bool) {
        if state {
            selectionStyle = .none
            imageTap.image = UIImage(systemName: "checkmark")
        } else {
            selectionStyle = .default
            imageTap.image = UIImage(systemName: "plus")
        }
    }
    
    public func configureCell(name: String, image: UIImage) {
        nameLabel.text = name
        imageTap.image = image
    }
    
}
