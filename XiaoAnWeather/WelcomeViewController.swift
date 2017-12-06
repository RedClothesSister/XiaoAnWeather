//
//  WelcomeViewController.swift
//  XiaoAnWeather
//
//  Created by 黄君伟 on 2017/11/30.
//  Copyright © 2017年 黄君伟. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {
    
    private var scrollView = UIScrollView()
    private var pageControler = UIPageControl()
    private var startBtn = UIButton()
    
    // MARK: Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setScrollView()
        setpageController()
    }
    
    
    // MARK: Private Methods
    
    private func setScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView.contentSize = CGSize(width: 4 * view.frame.size.width, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        for i in 0 ..< 4 {
            let image = UIImage(named: "Welcome\(i+1)")
            let imageView = UIImageView()
            imageView.image = image
            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            imageView.frame.origin.x = CGFloat(i) * view.frame.size.width
            scrollView.addSubview(imageView)
            view.addSubview(pageControler)
        }
    }
    
    private func setpageController() {
        pageControler.alpha = 0.5
        pageControler.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 30)
        pageControler.currentPageIndicatorTintColor = UIColor.themeColor
        pageControler.pageIndicatorTintColor = UIColor.black
        pageControler.numberOfPages = 4
        pageControler.addTarget(self, action: Selector(("scrollViewDidEndDecelerating")), for: .valueChanged)
    }
    
    @objc private func startBtnTaped() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let Main = main.instantiateViewController(withIdentifier: "Main")
        self.present(Main, animated: true, completion: nil)
    }
    
    
    // MARK: ScrollViewDelegate Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / view.frame.size.width)
        pageControler.currentPage = index
        
        startBtn.setTitle("Start MR.Umbrella", for: .normal)
        startBtn.titleLabel?.font = UIFont(name: "Gill Sans", size: 20)
        startBtn.titleLabel?.textColor = UIColor.darkGray
        startBtn.frame = CGRect(x: 3 * view.frame.size.width + view.frame.size.width / 2 - 82, y: view.frame.size.height - 70, width: 164, height: 23)
        startBtn.alpha = 0.7
        startBtn.addTarget(self, action: #selector(WelcomeViewController.startBtnTaped), for: .touchUpInside)
        scrollView.addSubview(startBtn)
        
        switch index {
        case 3:
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                self.pageControler.isHidden = true
                self.startBtn.isHidden = false
            }, completion: nil)
        default:
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                self.pageControler.isHidden = false
                self.startBtn.isHidden = true
            }, completion: nil)
        }
    }
}
