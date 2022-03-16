# Petfinder #

This is an iOS App created using Swift and the [Petfinder API](https://www.petfinder.com/developers/v2/docs).
With this application you can consult a list of animals availables to adopt in New York City. 

<p align="left">
  <img src="Images/petsfinder_demo.gif" width="250">
</p>

* The main functionalities are: 
    * View the animals in order of proximity to you. 
    * Sort them by type. 
    * Search for a specific buddy by name.
    * Refresh the list by drag-to-refresh on the list
* You can also: 
    * See available organizations in the city that offer animals to adopt.
    * Choose an organization and start a conversation by sending an email with a single click on their map point.

## Requirements

* Xcode >= 13
* iOS >= 15.0
* Swift 5

## How to install
* Clone or download the project to your machine
* Modify the ApiKeys.swift file with your keys from the [Petsfinder](https://www.petfinder.com/developers/v2/docs/) developer portal. You need:
    * A Petfinder account; if you do not have one, create an account.
    * A Petfinder API Key (otherwise called Client ID) and Secret. (Visit that [link](www.petfinder.com/developers) to request one.)
* Open XCode and build the project using: ```Cmd```+ ```Shift``` + ```B```.
* Run the Tests using: ```Cmd``` + ```U```.
* Run the App using: ```Cmd``` + ```R```.

## Architecture

* MvvM Design Pattern.
* Library-less App
* UI developed 100% in code.
* Communication between View and ViewModel is done through the use of Combine.
* View flow navigation is done by the use of the Coordinator pattern.
* The ViewModel performs the conversion of DTO to App Model and gets data from the API by using: 
  * ApiResource: model which offers URL formed by the different components.
  * ApiProvider: application connector to an internet resource.
  * ApiError: Error wrapper for the application.

* Each feature splits on:
  * FeatureCoordinator
  * FeatureViewController
  * FeatureViewModel 
  * Components
  * DecoderFactory: converter from DTO to App Model 

## Testing 87,7% coverage
* UnitTest: offline, using mock data. Also available online mode.
* UITest: main view flows and actions.
