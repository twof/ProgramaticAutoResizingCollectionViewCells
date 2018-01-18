//
//  Cell.swift
//  CollectionViewAutoSizingTest
//
//  Created by Wasin Wiwongsak on 1/25/17.
//  Copyright © 2017 Wasin Wiwongsak. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    struct CheckBoxPresenter {

        func configure(
            checkBox view: CheckBoxView,
            withTaskStatus isResolved: Bool,
            action callback: @escaping (CheckBoxView) -> Void
        ) {
            view.status = isResolved ? .checked : .unchecked
            view.pressAction = callback
        }
    }

    var checkBoxPresenter = CheckBoxPresenter()

    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
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

        label.accessibilityIdentifier = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)

        label.textColor = .black
        label.clearsContextBeforeDrawing = true
        label.numberOfLines = 0
        label.backgroundColor = .brown
        return label
    }()

    var staticView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        return view
    }()

    var checkBoxView: CheckBoxView!

    func setupCheckBoxView(isChecked: Bool) -> CheckBoxView {
        let checkBox = CheckBoxView(frame: .zero)
        checkBoxPresenter.configure(checkBox: checkBox, withTaskStatus: isChecked) { (cbv) in
            cbv.toggleStatus()
        }
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.clearsContextBeforeDrawing = true
        return checkBox
    }

    var labelStackView: UIStackView!
    var superStackView: UIStackView!

    func setupStackView() -> UIStackView {
        let view = UIStackView()
        view.accessibilityIdentifier = "StackView"
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addArrangedSubview(checkBoxView)
        view.addArrangedSubview(descriptionLabel)

        view.axis = .horizontal
        view.alignment = .top
        view.distribution = .fill
        view.spacing = 10

        return view
    }

    func setupSuperStackView() -> UIStackView {
        let view = UIStackView()
        view.accessibilityIdentifier = "SuperStackView"
        view.translatesAutoresizingMaskIntoConstraints = false

        view.addArrangedSubview(headerLabel)
        view.addArrangedSubview(labelStackView)

        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10

        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        view.clearsContextBeforeDrawing = true

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
        resetViews()
        let crashString = "This is the description of the view it's kinda long in order to make sure the view gets expanded and longer and longer and longer and longer and longer and longer This is the description of the view it's kinda long in order to make sure the view gets expanded and longer and longer and longer and longer and longer and longer sure the view gets expanded and longer and longer and longer"
        let safeString = "This is the description of the view it's kinda long in order to make sure the view gets expanded"
        descriptionLabel.text = crashString
        setupViews()
        setupConstraints(width: width)
    }

    func resetViews() {
        guard let stackView = self.superStackView else {return}
        stackView.removeFromSuperview()
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .purple
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.checkBoxView = setupCheckBoxView(isChecked: false)
        self.labelStackView = setupStackView()
        self.superStackView = setupSuperStackView()
        contentView.addSubview(self.superStackView)
    }

    func setupConstraints(width: CGFloat) {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: superStackView.topAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: superStackView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: superStackView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: superStackView.trailingAnchor)
        ])

//        NSLayoutConstraint.activate([
//            self.topAnchor.constraint(equalTo: contentView.topAnchor),
//            self.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor),
//            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])

        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalToConstant: width),
            self.contentView.heightAnchor.constraint(equalTo: superStackView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            self.superStackView.widthAnchor.constraint(equalToConstant: width)
        ])

        NSLayoutConstraint.activate([
            self.checkBoxView.heightAnchor.constraint(equalToConstant: 20),
            self.checkBoxView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
