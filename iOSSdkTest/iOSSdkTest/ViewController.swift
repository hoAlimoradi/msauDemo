//
//  ViewController.swift
//  iOSSdkTest
//
//  Created by Hosein Alimoradi on 12/12/1400 AP.
//


import UIKit
import cryptography

extension UIColor {
  
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cString.hasPrefix("#") { cString.removeFirst() }
    
    if cString.count != 6 {
      self.init("ff0000") // return red color for wrong hex input
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}

class ViewController: UIViewController {
    
    var titleLableView: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.text =  "محیط اپلیکیشن کارفرما"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var getUUIDButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .gray
        //button.titleLabel?.textColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.setTitle(" مشاهده UUID ", for: .normal)
        return button
    }()
    
    var showHomeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.setTitle(" ورود به محیط امضاء همراه پارس ", for: .normal)
        return button
    }()
    
    /*
     var showRegistrationBySignedMsisdnButton: UIButton = {
         let button = UIButton(type: .custom)
         button.backgroundColor = .red
         button.translatesAutoresizingMaskIntoConstraints = false
         button.widthAnchor.constraint(equalToConstant: 150).isActive = true
         button.heightAnchor.constraint(equalToConstant: 60).isActive = true
         button.setTitle(" Registration ", for: .normal)
         return button
     }()
     
     var showRegistrationByOTPButton: UIButton = {
         let button = UIButton(type: .custom)
         button.backgroundColor = .red
         button.translatesAutoresizingMaskIntoConstraints = false
         button.widthAnchor.constraint(equalToConstant: 150).isActive = true
         button.heightAnchor.constraint(equalToConstant: 60).isActive = true
         button.setTitle(" By OTP ", for: .normal)
         return button
     }()
     */
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(titleLableView)
        self.view.addSubview(getUUIDButton)
        self.view.addSubview(showHomeButton)
     
        
        getUUIDButton.addTarget(self,
                                action: #selector(self.getUUID(sender: )), for: .touchUpInside)
        
        showHomeButton.addTarget(self,
                                 action: #selector(self.showHome(sender: )), for: .touchUpInside)
        /*
         showRegistrationBySignedMsisdnButton.addTarget(self,
                                                        action: #selector(self.showRegistrationBySignedMsisdn(sender: )), for: .touchUpInside)
         
         showRegistrationByOTPButton.addTarget(self,
                                               action: #selector(self.showRegistrationByOtp(sender: )), for: .touchUpInside)
         
         */
         
        print( MSAU.getInstance().getUUID())
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        titleLableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
        titleLableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0).isActive = true
        titleLableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20.0).isActive = true
        
        
        getUUIDButton.topAnchor.constraint(equalTo: self.titleLableView.bottomAnchor, constant: 100.0).isActive = true
        
        getUUIDButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0).isActive = true
        getUUIDButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20.0).isActive = true
        
        showHomeButton.topAnchor.constraint(equalTo: self.getUUIDButton.bottomAnchor, constant: 50.0).isActive = true
        
        showHomeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0).isActive = true
        showHomeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20.0).isActive = true
       
        
    }
    
    
    func createStackView(with layout: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = layout
        stackView.distribution = .equalSpacing
        stackView.spacing = 50
        return stackView
    }
    
    @objc func getUUID(sender :UIButton) {
        var uuid = "not registerd"
        uuid = MSAU.getInstance().getUUID()
        print(uuid)
        // create the alert
                let alert = UIAlertController(title: "My UUID", message: uuid, preferredStyle: .alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showHome(sender :UIButton) {
        MSAU.getInstance().showMSAUUI(host: self)
    }
    
    @objc func showRegistrationByOtp(sender :UIButton) {
        do {
            
            try MSAU.getInstance().showRegistrationByOTP(host: self)
            
        }
        
        catch {
             
        }
        
    }
    
    @objc func showRegistrationBySignedMsisdn(sender :UIButton) {
        let msisdn = "989125441886"
        let signedMsisdn = "R88Vfj5LfJnskd5j/kfmFACN5vn9bDJnufRBVjCII/12X0SSrGahlfoRJmdETagm9mij0sbnnCkMnAOxQYY8whUhYKWzJ166Z0AeY5g6Y+j2ej4kQh96HXFGIW3+ISJjeLNvzfajhtVgSX5Nr2FGD4ODRNkMN/5oRc07+spJp708hIxjcPvApVPxNygXFgOIEtHR85JRiIAg+m+P0WYbnqoIf3ragFZpgYa/d6/kGk+UKQx+TnFp/KD8UZ+Y7uuHM5emIMWfNOWe8Y6X0irhN9nabyIp7eMWW/czDnfNtznitEeww+cR+1Ir8Cobt7w89fVMGZ4U//7qmmZqw+X5KA=="
        
        do {
            
            try MSAU.getInstance().showRegistrationBySignedMsisdn(host: self,
                                                                  msisdn: msisdn,
                                                                  signedMsisdn: signedMsisdn)
            
            // Handle opening the resource
        }
        catch MSAU.CustomError.USER_REGISTERED_PREVIOUSLY {
            
            print( " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++  ")
            print( "     USER_REGISTERED_PREVIOUSLY ")
            print( " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++  ")
        }
        catch {
            // Handle other errors
        }
    }
    
    
}


