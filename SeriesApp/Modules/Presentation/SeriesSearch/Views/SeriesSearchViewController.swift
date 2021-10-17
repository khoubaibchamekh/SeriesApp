//
//  SeriesSearchViewController.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit
import Combine

class SeriesSearchViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinnerView: SpinnerView!
    //MARK: typealias
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Serie>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Serie>
    //MARK: Properties
    var viewModel: SeriesSearchViewModel?
    private var dataSource: DataSource!
    private var bindings = Set<AnyCancellable>()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewLayout = SNCollectionViewLayout()
        collectionViewLayout.fixedDivisionCount = 2
        collectionViewLayout.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout
        setUpViews()
        configureDataSource()
        setUpBindings()
    }
    
    //MARK: - Setup UI
    private func setUpViews() {
        collectionView.backgroundColor = .white
        searchTextField.autocorrectionType = .no
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Serie name"
    }
    
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, serie) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SerieCell.identifier,
                    for: indexPath
                ) as? SerieCell
                
                cell?.configure(using: serie)
                return cell
            })
    }
      
    //MARK: - Setup Bindings
    private func setUpBindings() {
        guard let viewModel = viewModel else {
            return
        }
        
        searchTextField.textPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .assign(to: \.searchText, on: viewModel)
            .store(in: &bindings)
        
        viewModel.$series
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.updateSections()
            })
            .store(in: &bindings)
        
        let stateValueHandler: (SeriesSearchState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.startLoading()
            case .finishedLoading:
                self?.finishLoading()
            case .error(let error):
                self?.finishLoading()
                debugPrint(error.localizedDescription)
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
    //MARK: - UI Actions
    private func startLoading() {
        collectionView.isUserInteractionEnabled = false
        searchTextField.isUserInteractionEnabled = false
        spinnerView.startAnimating()
    }
    
    private func finishLoading() {
        collectionView.isUserInteractionEnabled = true
        searchTextField.isUserInteractionEnabled = true
        spinnerView.stopAnimating()
    }
    
    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.series])
        snapshot.appendItems(viewModel?.series ?? [])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension SeriesSearchViewController: SNCollectionViewLayoutDelegate {
    func scaleForItem(inCollectionView collectionView: UICollectionView,
                      withLayout layout: UICollectionViewLayout,
                      atIndexPath indexPath: IndexPath) -> UInt {
        return 1
    }
}
