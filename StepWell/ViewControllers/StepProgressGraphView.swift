//
//  HomeViewController.swift
//  StepWell
//
//  Created by Pawan on 22/02/23.
//

import UIKit
import HealthKit

class StepProgressGraphView: UIViewController {
//    create an instance of the HKHealthStore.
    @IBOutlet weak var stepsLabel: UILabel!
    private let healthStore = HKHealthStore()
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.sync {
            self.authorizeHealthKit()  // alow permission to count steps
//        }
        
        // Do any additional setup after loading the view.
    }
    func authorizeHealthKit(){
//        This function provides to authorize the HealthKit
        let healthKitDataType: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! ]
        healthStore.requestAuthorization(toShare: healthKitDataType, read: healthKitDataType) { (Success, error ) in
            if Success{
                //Authorization is successful.
                self.showAlert(alertTitle: "", "you made it")
                print("you made it---->")
                self.getStepCount() { stepCount in // This function provides to get the step count of the users.
                    DispatchQueue.main.async {
                        print("Step count is:", Int(stepCount)) // Get the step count.
                        self.stepsLabel.text = "Step count is : " + String(Int(stepCount))
                        
                    }
                }
            }
            else if (error != nil){
                //handle Error
                print("Error - Error in Authorization healthKit")
                self.showAlert(alertTitle: "Error", "Error in Authorization healthKit")
            }
        }
    }
    func getStepCount(completion: @escaping (Double) -> Void) {
        //            We are setting the time interval for type StepCount
        let type = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        var interval = DateComponents()
        interval.day = 1
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .hour, value: -1, to: now as Date), end: now, options: .strictEndDate) // try passing null if throw error
        // makeing a query of the step count for the interval.
        // HKStatisticsCollectionQuery allows an update handler, which is used to update the user’s step count more frequently throughout the day.
        let queryStepCounts = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startOfDay, intervalComponents: interval)
        queryStepCounts.initialResultsHandler = { _, result, error in
            var resultStepCount = 0.0
            result!.enumerateStatistics(from: startOfDay, to: now) { statistics, _ in
            if let sumQuantity = statistics.sumQuantity() {
                // Get steps count as Double.
                resultStepCount = sumQuantity.doubleValue(for: HKUnit.count())
            }
            DispatchQueue.main.sync {
                // Return the step count.
                completion(resultStepCount) } } }
        queryStepCounts.statisticsUpdateHandler = {
            queryStepCounts, statistics, statisticsCollection, error in
            // If new statistics are available
            if let sumQuantity = statistics?.sumQuantity() {
                let resultStepCount = sumQuantity.doubleValue(for: HKUnit.count())
                // Return
                DispatchQueue.main.sync {
                    // Return the updated step count.
                    completion(resultStepCount) } } }
         healthStore.execute(queryStepCounts)
        }

}
