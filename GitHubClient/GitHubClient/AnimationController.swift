//
//  AnimationController.swift
//  GitHubClient
//
//  Created by Joey Nessif on 8/22/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit


//Brad Johnson code
class AnimationController: NSObject {
  
  override init() {
  }
}

extension AnimationController : UIViewControllerAnimatedTransitioning {
    
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.4
  }
    
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
      //this is the animation
      
      if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UsersViewController,
        toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? DetailViewController {
          //containerView comes with the fromVC's view already installed
          let containerView = transitionContext.containerView()
          
          toVC.view.alpha = 0
          containerView.addSubview(toVC.view)
          
          let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
          let userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as! AvatarCell
          
          let snapShot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
          
          snapShot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
          
          containerView.addSubview(snapShot)
          userCell.hidden = true
          
          //ensure that my destination image view is in place
          toVC.view.layoutIfNeeded()
          
          toVC.imageView.hidden = true
          
          let destinationFrame = toVC.imageView.frame
          
          UIView.animateWithDuration(0.4, animations: { () -> Void in
            snapShot.frame = destinationFrame
            toVC.view.alpha = 1
            }, completion: { (finished) -> Void in
              userCell.hidden = false
              toVC.imageView.hidden = false
              snapShot.removeFromSuperview()
              if finished {
                transitionContext.completeTransition(finished)
              } else {
                transitionContext.completeTransition(finished)
              }
          })
      
      }
      
    }
    
  }
   

