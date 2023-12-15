//
//  ViewController.swift
//  Project28
//
//  Created by Yulian Gyuroff on 9.12.23.
//
import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Nothing to see here"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveSecretMessage))
        navigationItem.rightBarButtonItem?.setValue(true, forKey: "hidden")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @IBAction func registerTapped(_ sender: Any) {
        
        let ac = UIAlertController(title: "Sign Up", message: nil, preferredStyle: .alert)
        
        ac.addTextField { textLogon in
            textLogon.placeholder = "Enter username"
        }
        ac.addTextField { textPassword in
            textPassword.placeholder = "Enter password"
            textPassword.isSecureTextEntry = true
        }
        
        let registerAction = UIAlertAction(title: "Register", style: .default) { action in
            let username = ac.textFields![0].text
            let password = ac.textFields![1].text
            guard !username!.isEmpty,!password!.isEmpty else { return }
            KeychainWrapper.standard.set(username!, forKey: "username")
            KeychainWrapper.standard.set(password!, forKey: "password")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(registerAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    @IBAction func authenticateTapped(_ sender: Any) {
        //unlockSecretMessage()
        let ac = UIAlertController(title: "Sign In", message: nil, preferredStyle: .alert)
        
        ac.addTextField { username in
            username.placeholder = "Enter username"
        }
        ac.addTextField { password in
            password.placeholder = "Enter password"
            password.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let loginAction = UIAlertAction(title: "Login", style: .default) { [weak self] action in
            let username = ac.textFields![0].text
            let password = ac.textFields![1].text
            if username == KeychainWrapper.standard.string(forKey: "username") &&
                password == KeychainWrapper.standard.string(forKey: "password") {
                self?.unlockSecretMessage()
            } else {
                self?.authenticateWithBiometric()
            }
        }
        ac.addAction(loginAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        }else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem?.setValue(false, forKey: "hidden")
    }
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
       
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.rightBarButtonItem?.setValue(true, forKey: "hidden")
        
    }
    
    func authenticateWithBiometric() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        //error
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
            
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}

