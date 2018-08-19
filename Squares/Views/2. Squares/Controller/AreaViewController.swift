//
//  AreaViewController.swift
//  Squares
//
//  Created by Yaroslav Abaturov on 16/08/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController, UIScrollViewDelegate {

    var viewModel: AreaViewModelType?
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 5
            scrollView.delegate = self
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        guard let model = viewModel else { return UIView() }

        return model.getAreaView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = viewModel else { return }
        scrollView.contentSize = model.getContentSize()
        addAreaViewToScrollView()
        
        self.navigationController?.hidesBarsOnSwipe = true
        
        
        // Do any additional setup after loading the view.
    }

    private func addAreaViewToScrollView() {
        guard let model = viewModel else { return }

        scrollView.addSubview(model.getAreaView())
    }
    
    
    
    
    
}
