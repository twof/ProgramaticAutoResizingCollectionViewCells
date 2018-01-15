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
//        label.bounds = CGRect(x: , y: <#T##Int#>, width: label.frame.width, height: label.frame..)
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
//        NSLayoutConstraint.activate([
//            headerLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20)
//        ])
        view.isLayoutMarginsRelativeArrangement = true
//        view.isBaselineRelativeArrangement = false
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.accessibilityIdentifier = "ContentView"
        self.accessibilityIdentifier = "CardView"
//        setupViews()
//        setupConstraints(width: 50)
//        layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(width: CGFloat) {
        descriptionLabel.text = "This is the description of the view it's kinda long in order to make sure the view gets expanded"
        setupViews()
        layoutIfNeeded()
        setupConstraints(width: width)
        layoutIfNeeded()
//        let constraints = self.constraintsAffectingLayout(for: .horizontal)
//        constraints[1].isActive = false
//        print(constraints)
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .purple
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
//        self.translatesAutoresizingMaskIntoConstraints = false
        self.labelStackView = setupStackView()
        contentView.addSubview(labelStackView)
//        contentView.addSubview(headerLabel)
//        contentView.addSubview(descriptionLabel)
    }

    func setupConstraints(width: CGFloat) {
//        super.updateConstraints()

//        let widthAnchor = self.contentView.widthAnchor.constraint(equalToConstant: width)
//        widthAnchor.priority = 1000
//
//         Self constraints

        NSLayoutConstraint.activate([
            staticView.heightAnchor.constraint(equalToConstant: 20)
        ])


        NSLayoutConstraint.activate([
//            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)

            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        let multiplier: CGFloat = (labelStackView.bounds.height + 20) / labelStackView.bounds.height

        NSLayoutConstraint.activate([
//            self.contentView.heightAnchor.constraint(equalTo: labelStackView.heightAnchor, multiplier: 1),
//            self.contentView.heightAnchor.constraint(equalTo: labelStackView.an)
            self.contentView.widthAnchor.constraint(equalToConstant: width)
        ])

        // Title label constraints
//        NSLayoutConstraint.activate([
//            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
//        ])

//        // Description label constraints
//        NSLayoutConstraint.activate([
//            descriptionLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
//            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
//            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
    }
}

extension Cell {


//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //Exhibit A - We need to cache our calculation to prevent a crash.
//        if !isHeightCalculated {
//            setNeedsLayout()
//            layoutIfNeeded()
//            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//            var newFrame = layoutAttributes.frame
//            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//            layoutAttributes.frame = newFrame
//            isHeightCalculated = true
//        }
//        return layoutAttributes
//    }
}
