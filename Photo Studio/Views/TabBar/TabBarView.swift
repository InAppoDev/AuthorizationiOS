//
//  TabBarView.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 06.12.2020.
//

import UIKit

protocol TabBarViewProtocol: class {

}

enum TabBarItems {
    case search
    case favorites
    case bookings
    case wallet
    case settings
}

class TabBarView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var bookingsImage: UIImageView!
    @IBOutlet weak var bookingsButton: UIButton!
    @IBOutlet weak var walletImage: UIImageView!
    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    private func resetContent() {

    }
    
    private func setupView() {
        containerView.setGradientBackgroundTabBarView()
    }
    
    private func selectItemTabBar(_ item: TabBarItems) {
        searchImage.isHidden = item != .search
        searchButton.setImage(item != .search ? .appImage(.searchRegular) : nil, for: .normal)
        
        favoritesImage.isHidden = item != .favorites
        favoritesButton.setImage(item != .favorites ? .appImage(.favoritesRegular) : nil, for: .normal)
        
        bookingsImage.isHidden = item != .bookings
        bookingsButton.setImage(item != .bookings ? .appImage(.bookingsRegular) : nil, for: .normal)
        
        walletImage.isHidden = item != .wallet
        walletButton.setImage(item != .wallet ? .appImage(.walletRegular) : nil, for: .normal)
        
        settingsImage.isHidden = item != .settings
        settingsButton.setImage(item != .settings ? .appImage(.settingsRegular) : nil, for: .normal)
        
    }
    
    // MARK: - IBActions
    @IBAction func pressTabBarItem(_ sender: UIButton) {
        switch sender {
        case searchButton:
            print("Search")
            selectItemTabBar(.search)
        case favoritesButton:
            print("Favorites")
            selectItemTabBar(.favorites)
        case bookingsButton:
            print("Bookengs")
            selectItemTabBar(.bookings)
        case walletButton:
            print("Wallet")
            selectItemTabBar(.wallet)
        case settingsButton:
            print("Settings")
            selectItemTabBar(.settings)
        default:
            print("Error")
            break
        }
    }
    
}

extension TabBarView: TabBarViewProtocol {
    
   
}
