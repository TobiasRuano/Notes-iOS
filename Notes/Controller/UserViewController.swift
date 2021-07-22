//
//  UserViewController.swift
//  Notes
//
//  Created by Tobias Ruano on 07/07/2021.
//

import UIKit

class UserViewController: UIViewController, UINavigationControllerDelegate {
    
    var userView: NOUserView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        let barImage = UIImage(systemName: "lock.slash")
        let logOut = UIBarButtonItem(image: barImage, style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = logOut
        
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(imagePressed))
        userView.imageView.isUserInteractionEnabled = true
        userView.imageView.addGestureRecognizer(tapGesture)
        imagePicker.delegate = self
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        userView = NOUserView(name: "Tobias Ruano")
        view.addSubview(userView)
        userView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            userView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            userView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            userView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func imagePressed() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func logOut() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "token")
        let onboardingVc = OnboardingVC()
        onboardingVc.modalPresentationStyle = .fullScreen
        present(onboardingVc, animated: true, completion: nil)
    }
}

extension UserViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.userView.imageView.contentMode = .scaleAspectFit
                self.userView.imageView.image = pickedImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}
