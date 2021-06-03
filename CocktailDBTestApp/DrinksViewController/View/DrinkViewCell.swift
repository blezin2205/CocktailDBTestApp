//
//  DrinkViewCell.swift
//  CocktailDBTestApp
//
//  Created by Blezin on 01.06.2021.
//

import UIKit

class DrinkViewCell: UITableViewCell {
     
    let drinkImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameDrinkLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    static let reuseId = "DrinkViewCell"
    
    func setCell(data: DrinksName) {
        drinkImageView.loadImageUsingUrlString(urlString: data.imageUrl)
        nameDrinkLabel.text = data.name
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(drinkImageView)
        addSubview(nameDrinkLabel)
        
        drinkImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: .zero), size: CGSize(width: 100, height: 100))
        nameDrinkLabel.anchor(top: topAnchor, leading: drinkImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 20), size: CGSize(width: .zero, height: 100))
    }
    
}
