import UIKit

//var greeting = "Hello, playground"


public class SpecialActions {
    public static func matchKeyCombo(sequence: String) -> Bool {
        
        var stringArray = sequence.split(separator: "A")
        print(stringArray)
        if stringArray[0].count == stringArray[1].count{
            return true
        }
        
        return false
    }
}

//#if !RunTests

print(SpecialActions.matchKeyCombo(sequence: "QEEAZCC"))

//#endif
