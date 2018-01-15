//
//  ViewController.swift
//  CollectionViewAutoSizingTest
//
//  Created by Wasin Wiwongsak on 1/25/17.
//  Copyright © 2017 Wasin Wiwongsak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
//        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        let cards = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cards.accessibilityIdentifier = "CardView"
        cards.translatesAutoresizingMaskIntoConstraints = false

        cards.backgroundColor = .white
        cards.register(Cell.self,
                       forCellWithReuseIdentifier: "Cell")
        cards.remembersLastFocusedIndexPath = true
        cards.layer.cornerRadius = 4
        return cards
    }()

//    var headerLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        label.clearsContextBeforeDrawing = true
//        label.numberOfLines = 0
//        label.accessibilityIdentifier = "Header"
//        label.backgroundColor = .yellow
//        //        label.bounds = CGRect(x: , y: <#T##Int#>, width: label.frame.width, height: label.frame..)
//        return label
//    }()
//
//    var descriptionLabel: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        label.clearsContextBeforeDrawing = true
//        label.numberOfLines = 0
//        label.accessibilityIdentifier = "Description"
//        label.backgroundColor = .brown
////        label.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 100)
//        return label
//    }()
//
//    var staticView: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .green
//        return view
//    }()
//
//    var labelStackView: UIStackView!
//    func setupStackView() -> UIStackView {
//        let stackView = UIStackView()
//        stackView.accessibilityIdentifier = "StackView"
//        stackView.axis = .vertical
//        stackView.alignment = .fill
//        stackView.distribution = .fill
//        stackView.spacing = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.addArrangedSubview(headerLabel)
//        stackView.addArrangedSubview(descriptionLabel)
//        stackView.addArrangedSubview(staticView)
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//
//        return stackView
//    }

    
    let randomTexts = [
//        "Aenean dapibus urna a ullamcorper malesuada. Ut tempor.",
//                       "Sed venenatis ligula massa, a vulputate ipsum fringilla eget. Ut justo erat, facilisis id rhoncus cursus, fringilla at.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum lobortis nibh metus, elementum tempus libero ornare vitae. Etiam sed leo pretium, consectetur turpis non, dapibus purus. Suspendisse potenti. Ut ut eros nunc. Cras nulla justo, porttitor non sapien at, iaculis.",
//        "Maecenas pellentesque sed magna in congue. Sed non lacus in mi posuere scelerisque. Aenean.",
//        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget ex a velit tincidunt sodales. Donec elementum nisi at enim tempus, et rutrum erat semper. Phasellus ultricies est nec finibus."
    ]
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        descriptionLabel.text = "This is the description of the view it's kinda long in order to make sure the view gets expanded"
//        headerLabel.text = randomTexts[0]
//        self.labelStackView = setupStackView()
//        view.addSubview(self.labelStackView)
        view.addSubview(collectionView)

        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView.register(UINib.init(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
//        NSLayoutConstraint.activate([
//            staticView.heightAnchor.constraint(equalToConstant: 20)
//        ])
//        NSLayoutConstraint.activate([
//            //            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            //            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            //            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            //            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
//
//            labelStackView.topAnchor.constraint(equalTo: view.topAnchor),
////            labelStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            labelStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
//            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//        view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    override func viewWillLayoutSubviews() {
//        collectionView.collectionViewLayout.invalidateLayout()
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        return CGSize(width: screenWidth - 16, height: 1)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomTexts.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.headerLabel.text = randomTexts[indexPath.row]
        cell.setup(width: collectionView.bounds.width)
        return cell
    }
}

// Found this at:
// https://stackoverflow.com/questions/32082726/the-behavior-of-the-uicollectionviewflowlayout-is-not-defined-because-the-cell
extension UICollectionViewFlowLayout {
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        super.shouldInvalidateLayout(forBoundsChange: newBounds)
        return true
    }
}

