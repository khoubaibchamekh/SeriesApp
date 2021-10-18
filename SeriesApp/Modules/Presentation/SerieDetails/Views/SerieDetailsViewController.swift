//
//  SerieDetailsViewController.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit
import Combine
import SDWebImage

class SerieDetailsViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playerContainer: UIView!

    //MARK: Properties
    var viewModel: SerieDetailsViewModel?
    private var bindings = Set<AnyCancellable>()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpBindings()
    }
    
    //MARK: - Setup UI
    private func setUpViews() {
        titleLabel.text = viewModel?.currentSerie.title
        subtitleLabel.text = viewModel?.currentSerie.subtitle
        serieImageView.sd_setImage(
            with: URL(string: Constants.serverBaseUrl + (viewModel?.currentSerie.largeImageURL ?? "")),
            placeholderImage: UIImage(named: "defaultSerieImage"),
            options: .progressiveLoad,
            context: nil
        )
        
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "Details"
        /// Set left bar button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back"),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
    }
    
    @objc private func backAction() {
        viewModel?.didTapOnBack.send(Void())
    }
    
    //MARK: - Setup Bindings
    private func setUpBindings() {
        playButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let videoPlayerView = VideoPlayerView(frame: self?.playerContainer.bounds ?? .zero)
                self?.playerContainer.addSubview(videoPlayerView)
                self?.playerContainer.isUserInteractionEnabled = true
            }
            .store(in: &bindings)
        
        viewModel?.$seriePitch
            .filter { !$0.isEmpty }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] pitch in
                self?.descriptionLabel.text = pitch
                debugPrint("Updated description label: ", pitch)
            })
            .store(in: &bindings)
    }
}
