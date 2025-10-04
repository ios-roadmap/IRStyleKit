//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Ömer Faruk Öztürk on 4.10.2025.
//

import UIKit

class ReorderableCollectionViewHandler: NSObject, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    private var itemProvider: (IndexPath) -> ColorItem?
    private var reorderHandler: (IndexPath, IndexPath) -> Void
    private var dragSourceIndexPath: IndexPath?
    
    init(itemProvider: @escaping (IndexPath) -> ColorItem?, reorderHandler: @escaping (IndexPath, IndexPath) -> Void) {
        self.itemProvider = itemProvider
        self.reorderHandler = reorderHandler
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        self.dragSourceIndexPath = indexPath
        
        guard let item = itemProvider(indexPath) else { return [] }
        
        let itemProvider = NSItemProvider(object: item.text as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        self.dragSourceIndexPath = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard let sourceIndexPath = self.dragSourceIndexPath,
              let destinationIndexPath = destinationIndexPath else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
        if sourceIndexPath.section == destinationIndexPath.section {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        guard let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath else { return }
              
        guard sourceIndexPath.section == destinationIndexPath.section else { return }
        
        reorderHandler(sourceIndexPath, destinationIndexPath)
        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
}

struct ColorItem: Hashable {
    let uuid = UUID()
    let color: UIColor
    let text: String
}

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with title: String) {
        titleLabel.text = title
    }
}

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var reorderHandler: ReorderableCollectionViewHandler!

    var sectionedItems: [[ColorItem]] = [
        [
            ColorItem(color: .systemRed, text: "Kırmızı"),
            ColorItem(color: .systemGreen, text: "Yeşil"),
            ColorItem(color: .systemBlue, text: "Mavi")
        ],
        [
            ColorItem(color: .systemOrange, text: "Turuncu"),
            ColorItem(color: .systemPurple, text: "Mor"),
            ColorItem(color: .systemYellow, text: "Sarı"),
            ColorItem(color: .systemTeal, text: "Turkuaz"),
            ColorItem(color: .systemPink, text: "Pembe"),
            ColorItem(color: .systemBrown, text: "Kahverengi"),
            ColorItem(color: .systemIndigo, text: "İndigo"),
            ColorItem(color: .systemGray, text: "Gri"),
            ColorItem(color: .systemMint, text: "Nane"),
            ColorItem(color: .systemCyan, text: "Camgöbeği"),
            ColorItem(color: .systemGray2, text: "Gri 2"),
            ColorItem(color: .systemGray3, text: "Gri 3"),
            ColorItem(color: .systemGray4, text: "Gri 4"),
            ColorItem(color: .systemGray5, text: "Gri 5"),
            ColorItem(color: .systemGray6, text: "Gri 6")
        ]
    ]
    
    let sectionTitles = ["Ana Renkler", "Ara Renkler"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "Drag & Drop Listesi"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionView()
        setupDragAndDropHandler()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width - 40, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        layout.minimumLineSpacing = 15
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        
        collectionView.dataSource = self
        
        collectionView.dragInteractionEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupDragAndDropHandler() {
        reorderHandler = ReorderableCollectionViewHandler(
            itemProvider: { [weak self] indexPath in
                return self?.sectionedItems[indexPath.section][indexPath.item]
            },
            reorderHandler: { [weak self] sourceIndexPath, destinationIndexPath in
                guard let self = self else { return }
            
                self.collectionView.performBatchUpdates({
                    let movedItem = self.sectionedItems[sourceIndexPath.section].remove(at: sourceIndexPath.item)
                    self.sectionedItems[destinationIndexPath.section].insert(movedItem, at: destinationIndexPath.item)
                    
                    self.collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
                })
            }
        )
        
        collectionView.dragDelegate = reorderHandler
        collectionView.dropDelegate = reorderHandler
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionedItems[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as! ColorCell
        let item = sectionedItems[indexPath.section][indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        header.configure(with: sectionTitles[indexPath.section])
        return header
    }
}

class ColorCell: UICollectionViewCell {
    
    static let identifier = "ColorCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with item: ColorItem) {
        contentView.backgroundColor = item.color
        titleLabel.text = item.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateScale(isDown: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateScale(isDown: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateScale(isDown: false)
    }
    
    private func animateScale(isDown: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.transform = isDown ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
        }
    }
}
