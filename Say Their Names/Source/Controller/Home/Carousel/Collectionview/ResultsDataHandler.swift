//
//  ResultsDataHandler.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

///Provides default methods for interfacing with the results handler class.
protocol DataHandlerProtocol {
    var resultsHandler: ResultsDataHandler {get set}
    var resultsData: [Any]? {get}
}

struct ResultsDataHandler {

    ///Used to store the populated results.
    var resultsData: [Any]?

    /// Populates the resultsData array with data passed in.
    ///
    /// - Parameter data: what data you would like to pass to the results handler. Generic to handle any data structure.
    mutating func populateDataWith<T>(data: [T]) {
        clearArray()
        resultsData = data as [Any]
    }
    /// Returns results that are present in the resultsData array.
    ///
    /// - Returns: Returns the currently held data in the resultsData array
    func retriveDataFromHandeler<T>() -> [T] {
        guard let data = resultsData else {return []}
        return data as? [T] ?? []
    }

    ///Clears the array for use, a housekeeping function to prevent any data mismatches.
    private mutating func clearArray() {
        guard let array = resultsData else {return}
        if !array.isEmpty {
            resultsData = []
        }
    }

}
