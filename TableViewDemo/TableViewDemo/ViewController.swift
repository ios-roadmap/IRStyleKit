//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Ömer Faruk Öztürk on 4.10.2025.
//

import UIKit

// MARK: - Manager Sınıfı
class CollectionViewManager: NSObject, UICollectionViewDataSource {
    
    private weak var collectionView: UICollectionView?
    private var reorderHandler: ReorderableCollectionViewHandler!
    
    private var sectionedItems: [[ColorItem]]
    private let sectionTitles: [String]
    private let sectionBackgroundColors: [UIColor]
    
    init(collectionView: UICollectionView, items: [[ColorItem]], titles: [String], backgroundColors: [UIColor]) {
        self.collectionView = collectionView
        self.sectionedItems = items
        self.sectionTitles = titles
        self.sectionBackgroundColors = backgroundColors
        super.init()
        
        setupCollectionView()
        setupDragAndDropHandler()
    }
    
    private func setupCollectionView() {
        guard let collectionView = collectionView else { return }
        
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
        
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
    }
    
    private func setupDragAndDropHandler() {
        guard let collectionView = collectionView else { return }
        
        reorderHandler = ReorderableCollectionViewHandler(
            itemProvider: { [weak self] indexPath in
                return self?.sectionedItems[indexPath.section][indexPath.item]
            },
            reorderHandler: { [weak self] sourceIndexPath, destinationIndexPath in
                guard let self = self else { return }
                
                self.collectionView?.performBatchUpdates({
                    let movedItem = self.sectionedItems[sourceIndexPath.section].remove(at: sourceIndexPath.item)
                    self.sectionedItems[destinationIndexPath.section].insert(movedItem, at: destinationIndexPath.item)
                    self.collectionView?.moveItem(at: sourceIndexPath, to: destinationIndexPath)
                }, completion: { _ in
                    var indexPathsToReload: [IndexPath] = []
                    indexPathsToReload.append(destinationIndexPath)
                    
                    if self.sectionedItems[sourceIndexPath.section].count > 0 {
                        let newLastItemIndex = self.sectionedItems[sourceIndexPath.section].count - 1
                        let newLastIndexPath = IndexPath(item: newLastItemIndex, section: sourceIndexPath.section)
                        indexPathsToReload.append(newLastIndexPath)
                    }
                    self.collectionView?.reloadItems(at: Array(Set(indexPathsToReload)))
                })
            }
        )
        
        collectionView.dragDelegate = reorderHandler
        collectionView.dropDelegate = reorderHandler
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionedItems[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath) as! ColorCell
        let item = sectionedItems[indexPath.section][indexPath.item]
        let isLast = indexPath.item == sectionedItems[indexPath.section].count - 1 // Son hücre mi?
        let backgroundColor = sectionBackgroundColors[indexPath.section]
        cell.configure(with: item, backgroundColor: backgroundColor, isLastCell: isLast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
        let title = sectionTitles[indexPath.section]
        let backgroundColor = sectionBackgroundColors[indexPath.section]
        header.configure(with: title, backgroundColor: backgroundColor)
        return header
    }
}

// MARK: - ViewController
class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var collectionViewManager: CollectionViewManager!
    
    private let sectionedItems: [[ColorItem]] = [
        [
            ColorItem(color: .clear, text: "Kırmızı"),
            ColorItem(color: .clear, text: "Yeşil"),
            ColorItem(color: .clear, text: "Mavi")
        ],
        [
            ColorItem(color: .clear, text: "Turuncu"),
            ColorItem(color: .clear, text: "Mor"),
            ColorItem(color: .clear, text: "Sarı"),
        ]
    ]
    private let sectionTitles = ["Ana Renkler", "Ara Renkler"]
    private let sectionBackgroundColors: [UIColor] = [.secondarySystemGroupedBackground, .secondarySystemGroupedBackground]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "Sıralanabilir Liste"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionView()
        setupManager()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width - 16, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 66)
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    private func setupManager() {
        collectionViewManager = CollectionViewManager(
            collectionView: collectionView,
            items: sectionedItems,
            titles: sectionTitles,
            backgroundColors: sectionBackgroundColors
        )
    }
}

// MARK: - Model
struct ColorItem: Hashable {
    let uuid = UUID()
    let color: UIColor
    let text: String
}

// MARK: - Drag&Drop Handler
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
        guard let sourceIndexPath = self.dragSourceIndexPath, let destinationIndexPath = destinationIndexPath, sourceIndexPath.section == destinationIndexPath.section else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath, let item = coordinator.items.first, let sourceIndexPath = item.sourceIndexPath else { return }
        reorderHandler(sourceIndexPath, destinationIndexPath)
        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
}

// MARK: - Section Header
class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
              containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
              containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
              containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
              containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
              
              titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
              titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
              titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
              
              separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
              separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
              separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
              separatorView.heightAnchor.constraint(equalToConstant: 0.5)
          ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with title: String, backgroundColor: UIColor) {
        titleLabel.text = title
        containerView.backgroundColor = backgroundColor
    }
}


// MARK: - Color Cell
class ColorCell: UICollectionViewCell {
    
    static let identifier = "ColorCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with item: ColorItem, backgroundColor: UIColor, isLastCell: Bool) {
        titleLabel.text = item.text
        containerView.backgroundColor = backgroundColor
        separatorView.isHidden = isLastCell
        
        if isLastCell {
            containerView.layer.cornerRadius = 12
            containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            containerView.layer.cornerRadius = 0
            containerView.layer.maskedCorners = []
        }
    }
}
