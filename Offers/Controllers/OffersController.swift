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

    private var offersService: OffersService
    private var primaryView: OffersViewImplementation
    init(offersService: OffersService) {
        self.offersService = offersService
        self.primaryView = OffersViewImplementation(offers: offersService.getOffers())

        super.init(nibName: nil, bundle: nil)

        self.offersService.didUpdateOffer = { offer in
            self.primaryView.updateOffer(offer: offer)
        }
        self.primaryView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func loadView() {
        self.view = self.primaryView
    }
}

extension OffersController: Selectable {
    func didSelectOffer(offer: Offer) {
        coordinator?.viewOffer(offer: offer)
    }
}
