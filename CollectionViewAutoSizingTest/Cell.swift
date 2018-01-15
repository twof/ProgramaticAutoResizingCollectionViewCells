//
//  Cell.swift
//  CollectionViewAutoSizingTest
//
//  Created by Wasin Wiwongsak on 1/25/17.
//  Copyright © 2017 Wasin Wiwongsak. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    var isHeightCalculated: Bool = false

    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.clearsContextBeforeDrawing = true
        label.numberOfLines = 0
        label.accessibilityIdentifier = "Header"
        label.backgroundColor = .yellow
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.clearsContextBeforeDrawing = true
        label.numberOfLines = 0
        label.accessibilityIdentifier = "Description"
        label.backgroundColor = .brown
        return label
    }()

    var staticView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()

    var labelStackView: UIStackView!

    func setupStackView() -> UIStackView {
        let view = UIStackView()
        view.accessibilityIdentifier = "StackView"
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(headerLabel)
        view.addArrangedSubview(descriptionLabel)
        view.addArrangedSubview(staticView)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        return view
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.accessibilityIdentifier = "ContentView"
        self.accessibilityIdentifier = "CardView"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(width: CGFloat) {
        descriptionLabel.text = "This is the description of the view it's kinda long in order to make sure the view gets expanded"
        setupViews()
        setupConstraints(width: width)
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .purple
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.labelStackView = setupStackView()
        contentView.addSubview(labelStackView)
    }

    func setupConstraints(width: CGFloat) {
        NSLayoutConstraint.activate([
            staticView.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
