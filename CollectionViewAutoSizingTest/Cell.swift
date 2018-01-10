//
//  Cell.swift
//  CollectionViewAutoSizingTest
//
//  Created by Wasin Wiwongsak on 1/25/17.
//  Copyright © 2017 Wasin Wiwongsak. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.clearsContextBeforeDrawing = true
        label.numberOfLines = 0
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.clearsContextBeforeDrawing = true
        label.numberOfLines = 0
        return label
    }()

    let screenWidth = UIScreen.main.bounds.size.width

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints(width: 50)
        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(width: CGFloat) {
        descriptionLabel.text = "This is the description of the view it's kinda long in order to make sure the view gets expanded"
        setupViews()
        setupConstraints(width: width)
        layoutIfNeeded()
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .purple
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
//        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupConstraints(width: CGFloat) {
//        super.updateConstraints()

        let widthAnchor = self.widthAnchor.constraint(equalToConstant: width)
        widthAnchor.priority = 1000

        // Self constraints
//        NSLayoutConstraint.activate([
//            widthAnchor
//        ])

        // Title label constraints
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headerLabel.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -8),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        // Description label constraints
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
