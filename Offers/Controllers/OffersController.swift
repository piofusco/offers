//
//  OffersViewController.swift
//  Offers
//
//  Created by gideon on 1/31/18.
//  Copyright © 2018 piofusco. All rights reserved.
//

import UIKit

class OffersController: UIViewController {
    weak var coordinator: MainCoordinator?

    private let offersService: OffersService
    private var primaryView: OffersView
    init(offersService: OffersService) {
        self.offersService = offersService
        self.primaryView = OffersView(offers: offersService.getOffers())

        super.init(nibName: nil, bundle: nil)

        self.primaryView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func loadView() {
        self.view = self.primaryView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.primaryView = OffersView(offers: offersService.getOffers())
        self.primaryView.delegate = self
        self.primaryView.collectionView.reloadData()
        self.view = primaryView
    }
}

extension OffersController: Selectable {
    func didSelectOffer(offer: Offer) {
        coordinator?.viewOffer(offer: offer)
    }
}
