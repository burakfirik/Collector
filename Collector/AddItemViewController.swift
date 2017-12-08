//
//  AddItemViewController.swift
//  Collector
//
//  Created by Burak Firik on 11/30/17.
//  Copyright © 2017 Code Path. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imagePicker.delegate = self
    // Do any additional setup after loading the view.
  }
  
  var imagePicker = UIImagePickerController()
  
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var titleTextField: UITextField!
  
  
  @IBAction func photoTapped(_ sender: Any) {
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func cameraTapped(_ sender: Any) {
    imagePicker.sourceType = .camera
    present(imagePicker, animated: true, completion: nil)
  }
  @IBAction func addTapped(_ sender: Any) {
    
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      let item = Item(entity: Item.entity(), insertInto:context)
      
      item.title = titleTextField.text
      
      if let image = itemImageView.image {
        if let imageData = UIImagePNGRepresentation(image) as? Data {
          item.image = imageData as? NSData
        }
      }
      try? context.save()
      
      navigationController?.popViewController(animated: true)
    }
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      itemImageView.image = chosenImage
    }
    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
