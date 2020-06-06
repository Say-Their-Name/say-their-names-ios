//
//  ResultsDataHandler.swift
//  Say Their Names
//
//  Created by Thomas Murray on 06/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

///Provides default methods for interfacing with the results handler class.
protocol DataHandlerProtocol {
    associatedtype Data
    var resultsHandler: ResultsDataHandler<Data> {get set}
    var resultsData: [Any]? {get}
}

class ResultsDataHandler<Data> {

    // MARK: - Properties
    ///Used to store the populated results.
    var resultsData: [Data]?

    // MARK: - Init
    init(resultsData: [Data]) {
        self.resultsData = resultsData
    }

    // MARK: - Methods
    /// Populates the resultsData array with data passed in.
    ///
    /// - Parameter data: what data you would like to pass to the results handler. Generic to handle any data structure.
    func populateDataWith(data: [Data]) {
        clearArray()
        resultsData = data as [Data]
    }
    /// Returns results that are present in the resultsData array.
    ///
    /// - Returns: Returns the currently held data in the resultsData array
    func retriveDataFromHandeler() -> [Data] {
        guard let data = resultsData else {return []}
        return data
    }

    ///Clears the array for use, a housekeeping function to prevent any data mismatches.
    private func clearArray() {
        guard let array = resultsData else {return}
        if !array.isEmpty {
            resultsData = []
        }
    }

}
