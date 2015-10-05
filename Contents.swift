// Playground - noun: a place where people can play

// Janet Weber DUE 10/5/2015
// Critical Thinking Exercise (Week 7) Functions, Closures, Nested Functions
// Write a playground to do something useful for you in your daily life that contains the
// following items; a function, a nested function, and a closure.

// I chose to write code that helps with grocery shopping.  I start with my shopping
// list and dictionaries for each store I shop at, containing the items and location
// within that store.  The list is separated by store and then sorted by location of
// the itmes within that store so that I should be able to progress easily thru each
// store with my list in the physical order that I walk.  Now maybe I won't forget stuff
// that's on my grocery list!!

import UIKit
// *****************************************************
// Variables and Constants
// ****************************************************
// grocery list - this is my entire grocery list.  I can include items from several
// stores.  (Items on this list, but not in one of the store dictionaries will NOT
// be flagged at this time).
var groceries: [String] = ["milk", "cereal", "pop tarts", "bread", "coffee", "bananas",
    "uncrustables", "peanut butter", "lunch meat turkey", "bacon", "bottled water",
    "wine", "beer", "gatorade", "toilet paper", "facial tissue", "brick cheese",
    "sliced cheese", "salad bag", "sub buns", "picante sauce"]

// store dictionaries setup as item location.  Each included the items that I tend to
// buy at that particular store
var walmart: Dictionary<String, Int> = ["milk": 15, "cereal": 6, "pop tarts": 6, "bread": 3,
    "coffee": 4, "salad bag": 2, "peanut butter":4, "uncrustables": 13, "bananas": 1,
    "wine": 10, "beer": 10, "brick cheese": 11, "sub buns": 3, "picante sauce": 5]
var sams: Dictionary<String, Int> = ["bacon": 4, "bottled water": 10, "gatorade": 9,
    "toilet paper": 29, "facial tissue": 29, "olive garden dressing": 30,
    "sliced cheese": 6]

var walmartArr, samsArr: [String]   // result string arrays with items in order by location
// ***************************************************
// getList function: This function takes as parameters a store
//      dictionary and a grocery list (user input) and returns an
//      array of strings with items in that store dictionary sorted
//      by item location within store.
// ***************************************************
func getList(store: Dictionary<String, Int>, list: [String])  -> [String] {
    
    var i: Int                  // loop variable
    var storeArr = [String]()   // array to be returned (passed to sortList nested function)
    var location = [Int]()      // parallel array to storeArr of item locations (ints)
                                //     Both arrays are created in this function.
    
    //   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
    // sortList nested function:  this function takes as it's parameter
    //      and unsorted list of grocery items for a specific store.  It creates
    //      a location array (parrallel to input array) using the store
    //      dictionary (item, location).  It then sorts both arrays based on
    //      the location and returns the sorted item array.
    //   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *
    func sortList(unsortedList: [String]) -> [String] {
        var sortedList = [String]()                     // result array
        var tmpStr : String                             // temporary swap
        var tmpInt : Int                                //     variables
        var j, k, itemLoc, currentMin, listLength: Int  // various loop variables, indexes, etc.

        let smaller = {(n: Int, m: Int) -> Bool in      // closure called smaller that returns
            return n < m                                // true if first param is
        }                                               // less than second.
        
        listLength = unsortedList.count                 // initialize list length

        for (j=0; smaller(j,listLength); j++) {         // create location array - parallel
            if let itemLoc = store[unsortedList[j]] {   // to unsortedList of items array -
                location+=[itemLoc]                     // based on dictionary (item, location)
            }
        }
        
        sortedList = unsortedList                       // initialize sortedList because
        for (j=0; smaller(j,listLength-1); j++) {       // unsortedList is a parameter and
            currentMin = j;                             // therefore a constant.  Then proceed
            for (k=j+1; smaller(k, listLength); k++) {  // to sort based on location. Find
                if (smaller(location[k],
                    location[currentMin])) {             // next minimum element and swap
                    currentMin = k
                }
            }

            if (currentMin != j) {                      // swap if necessary - both arrays
                tmpStr = sortedList[j]
                sortedList[j] = sortedList[currentMin]  // item array
                sortedList[currentMin] = tmpStr
                
                tmpInt = location[j]
                location[j] = location[currentMin]      // location array
                location[currentMin] = tmpInt
                
            }
        }
        
        for (j=0; smaller(j,sortedList.count); j++){    // display list with location
            println("\(location[j])  \(sortedList[j])")
        }
        return sortedList                               // return sortedList
    }
    //   *  *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *  *
    // end of function sortList()
    //   *  *   *   *   *   *   *   *   *   *   *   *   *   *   *   *   *  *
    
    
    // Main code section for getList function.  Basically create the individual store array
    //       and  pass it to sort function and return
    for (i=0; i<list.count; i++) {      // go thru entire grocery list and create
        if (store[list[i]] != nil) {    // an array containing only the items from
            storeArr+=[list[i]]         // your list that you usually buy at this store
        }                               // using the store dictionary
    }
    
    return sortList(storeArr)           // sort the list by location within store and return
}
// ****************************
// end of function getList()
// ****************************

// main program:  just display store then call function with store and list

println("Walmart Items: ")
walmartArr = getList(walmart, groceries)

println("\nSam's Club items:  ")
samsArr = getList(sams, groceries)

// In the future, make sure nothing drops off this list (i.e. if there is something
//   on the grocery list that isn't in any of the store dictionaries - these items
//   should be flagged.
// loners = getLoners(groceries)
