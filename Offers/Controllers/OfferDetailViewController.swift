//
// Created by gideon on 2/10/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

class OfferDetailViewController: UIViewController {
    private var offer: Offer
    weak var coordinator: MainCoordinator?

    init(offer: Offer) {
        self.offer = offer

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let primaryView = OfferDetailView(offer: offer)
        primaryView.delegate = self
        view = primaryView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension OfferDetailViewController: Favoritable {
    func didFavoriteOffer(withId id: String) {
        coordinator?.didFavoriteOffer(withId: id)
    }
}