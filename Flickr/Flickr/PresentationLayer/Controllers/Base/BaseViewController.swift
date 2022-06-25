//
//  BaseViewController.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    // MARK: - Setting Views
    
    internal func addSubViews() {}
    
    // MARK: - Setting Constraints
    
    internal func setupConstraints() {}
}
