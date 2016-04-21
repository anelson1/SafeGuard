//
//  PicturesPageViewController.swift
//  SafeGuard
//
//  Created by Student on 4/18/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class PicturesPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }// Do any additional setup after loading the view.
    }

}
extension PicturesPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
private(set) var orderedViewControllers: [UIViewController] = {
    return [newColoredViewController("Green"),
            newColoredViewController("Red"),
            newColoredViewController("Blue")]
}()

private func newColoredViewController(color: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewControllerWithIdentifier("\(color)ViewController")
}
func pageViewController(pageViewController: UIPageViewController,
                        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
        return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
        return nil
    }
    
    guard orderedViewControllers.count > previousIndex else {
        return nil
    }
    
    return orderedViewControllers[previousIndex]
}

func pageViewController(pageViewController: UIPageViewController,
                        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
        return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    guard orderedViewControllersCount != nextIndex else {
        return nil
    }
    
    guard orderedViewControllersCount > nextIndex else {
        return nil
    }
    
    return orderedViewControllers[nextIndex]
}
