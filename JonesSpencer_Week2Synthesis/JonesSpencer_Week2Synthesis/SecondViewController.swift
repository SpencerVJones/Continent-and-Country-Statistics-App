//
//  SecondViewController.swift
//  JonesSpencer_Week2Synthesis
//
//  Created by Spencer Jones on 3/15/24.
//


import UIKit
class SecondViewController: UIViewController {
    
    // Outlets
    @IBOutlet var continentNameLabel: UILabel!
    @IBOutlet var infoTextView: UITextView!
    @IBOutlet var addCountryButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
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
        updateInfoTextView()
    }
    
    // Function to update labels
    func updateInfoTextView() {
        if let continentName = continentName,
           let countryNames = countryNames,
           let countryPopulations = countryPopulations,
           let continentPopulation = continentPopulation,
           let totalCountries = totalCountries {
            
            var infoText = "There are \(totalCountries) countries in \(continentName), with a total population of \(continentPopulation) people.\n"
            
            // Append each country name and population to the infoText
            for i in 0..<min(countryNames.count, countryPopulations.count) {
                let countryName = countryNames[i]
                let countryPopulation = countryPopulations[i]
                infoText += "\n\(countryName) has a population of \(countryPopulation) people.\n"
            }
            
            infoTextView.text = infoText
            continentNameLabel.text = continentName
        }
    }

    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
            // Pass information to the third view controller
            thirdVC.continents = continents
            thirdVC.continentName = continentName
            thirdVC.countryNames = countryNames
            thirdVC.countryPopulations = countryPopulations
            thirdVC.continentPopulation = continentPopulation
            thirdVC.totalCountries = totalCountries
            
            // Present the ThirdViewController
            present(thirdVC, animated: true, completion: nil)
        }
    }
    
    
    // Unwind from third controller
    @IBAction func unwindFromThirdViewController(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? ThirdViewController {
            updateInfoTextView()
            if let sourceViewController = segue.source as? ThirdViewController {
                continents = sourceViewController.continents ?? [:]
                updateInfoTextView()
            }
        }
    }
}
