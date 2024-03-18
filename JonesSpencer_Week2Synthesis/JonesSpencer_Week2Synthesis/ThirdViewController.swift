//
//  ThirdViewController.swift
//  JonesSpencer_Week2Synthesis
//
//  Created by Spencer Jones on 3/15/24.
//

import UIKit
class ThirdViewController: UIViewController {
    
    // Outlets
    @IBOutlet var countryNameTextField: UITextField!
    @IBOutlet var countryPopulationTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    // Variables
    var continentName: String?
    var countryNames: [String]?
    var countryPopulations: [Int]?
    var continentPopulation: Int?
    var totalCountries: Int?
    var continents: [String: [String: Int]]?
    var totalPopulation: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // Retrieve the values from the text fields
        guard let countryName = countryNameTextField.text, !countryName.isEmpty
        else {
            showAlert(message: "Please enter a country name.")
            return
        }
        guard let countryPopulationText = countryPopulationTextField.text, let countryPopulation = Int(countryPopulationText), countryPopulation >= 0
        else {
            showAlert(message: "Please enter a valid population.")
            return
        }
        
        // Ensure that continentName is not nil
        guard let continentName = continentName else {
            showAlert(message: "Continent information is missing.")
            return
        }
                
        // Update the continents dictionary
        if var continentData = continents?[continentName] {
            continentData[countryName] = countryPopulation
            continents?[continentName] = continentData
        } else {
            continents?[continentName] = [countryName: countryPopulation]
        }
                
        // Update countryNames and countryPopulations arrays in SecondViewController
        if let presentingVC = presentingViewController as? SecondViewController, let continentData = continents?[continentName] {
            presentingVC.countryNames = Array(continentData.keys)
            presentingVC.countryPopulations = Array(continentData.values)
            presentingVC.updateInfoTextView()
                    
            if var countryNames = countryNames, let countryName = countryNameTextField.text {
                countryNames.append(countryName)
                self.countryNames = countryNames
            }
        }
    }
        
    // Helper method to show alert message
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

