//
// Created by gideon on 2/10/18.
// Copyright (c) 2018 piofusco. All rights reserved.
//

import UIKit

class OfferDetailController: UIViewController {
    private var offer: Offer
    weak var delegate: Favoritable?

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

extension OfferDetailController: Favoritable {
    func didFavoriteOffer(withId id: String) {
        delegate?.didFavoriteOffer(withId: id)
    }
}