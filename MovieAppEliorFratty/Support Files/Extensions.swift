//
//  Extensions.swift
//  Soccer
//
//  Created by User on 05/04/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImageUsingCatchWithUrlString(URLString: String){
        
        self.image = nil
        
        if let chachedImage = imageCache.object(forKey: URLString as AnyObject) as? UIImage {
            self.image = chachedImage
            return
        }
        
        let url = URL(string: URLString)
        
        guard let url2 = url else {print("cant uplaod Image With? \(String(describing: url))") ; return}
        
        URLSession.shared.dataTask(with: url2) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: URLString as AnyObject)
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}

extension UIButton {
    
    
    
    func pulsate() {
       
        let puls = CASpringAnimation(keyPath: "transform.scale")
        puls.duration = 0.6
        puls.fromValue = 1.0
        puls.toValue = 0.9
        puls.autoreverses = true
        puls.repeatCount = 1
        puls.initialVelocity = 0.5
        puls.damping = 1.0
        
        layer.add(puls, forKey: nil)
    }
    
    func flash() {
        
        let puls = CASpringAnimation(keyPath: "opacity")
        puls.duration = 0.5
        puls.fromValue = 1
        puls.toValue = 0.1
        puls.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        puls.autoreverses = true
        puls.repeatCount = 3

        layer.add(puls, forKey: nil)
    }
    
    func shake() {
        
        let puls = CASpringAnimation(keyPath: "position")
        puls.duration = 0.1

        puls.autoreverses = true
        puls.repeatCount = 2
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        puls.fromValue = fromValue
        puls.toValue = toValue

        layer.add(puls, forKey: nil)
    }
}

extension UIViewController {
    func popUpEror(error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retary", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    func popUpEror(string: String){
        let alert = UIAlertController(title: "Error", message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retary", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

extension Date {
    func toString(dateFormat format: String ) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: self)
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach{ addSubview($0)}
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    
    func centerInXPositionSuperview(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true

        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true

    }
    
    func centerInYPositionSuperview(leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
    }
    
    
}

extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        return 0;
    }
}
