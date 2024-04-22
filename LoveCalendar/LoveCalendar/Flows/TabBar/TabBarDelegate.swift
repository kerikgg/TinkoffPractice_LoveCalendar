//
//  TabBarDelegate.swift
//  LoveCalendar
//
//  Created by kerik on 21.04.2024.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    var onViewDidAppear: ((UINavigationController) -> Void)? { get set }
    var onCalendarFlow: ((UINavigationController) -> Void)? { get set }
    var onWishlistFlow: ((UINavigationController) -> Void)? { get set }
    var onMainFlow: ((UINavigationController) -> Void)? { get set }
    var onAlbumFlow: ((UINavigationController) -> Void)? { get set }
    var onProfileFlow: ((UINavigationController) -> Void)? { get set }
}
