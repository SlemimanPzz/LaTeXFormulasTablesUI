//
//  Formulas.swift
//  LaTeX Logic Formulas
//
//  Created by Emiliano Apodaca on 17/09/22.
//

import Foundation


enum LogicConnectors : String {
    case Conguntion = "∧"
    case Disyuntion = "∨"
    case Implication = "→"
    case Negation = "¬"
    case Biconditional = "↔"
    case None = ""
}

enum FormulaError : Error {
    case LogicConnectorIsNone
    case NoRightFormula
}

class Formula : CustomStringConvertible{
    
    var variable : UInt?
    var leftFormula : Formula?
    var connector : LogicConnectors
    var rightFormula : Formula?
    
    
    public var description: String {
        if self.connector == .None {
            let string = "x\(variable!)"
            return string
        }
        else if self.connector == .Negation {
            let negation = "(¬\(leftFormula!))"
            return negation
        }
        else {
            let binaryFormula = "(\(leftFormula!) \(connector.rawValue) \(rightFormula!))"
            return binaryFormula
        }
    }
    
    
    
    /// Initializer of negation or binary logic formulas,  ``LogicConnectors.None`` is not accepted.
    /// - Parameters:
    ///   - leftFormula: The left formula on the complete one, or the only one if the ``connector`` is ``LogicConnector.Negation``.
    ///   - connector: The connector that will be use un the formula.
    ///   - rightFormula: The right formula of the complete one, if connector nor ``LogicConnector.Negation``
    init(leftFormula : Formula, connector : LogicConnectors , rightFormula : Formula?) throws {
        if connector == LogicConnectors.None {
            throw FormulaError.LogicConnectorIsNone
        }
        
        if connector == LogicConnectors.Negation && rightFormula == nil {
            self.connector = LogicConnectors.Negation
            self.leftFormula = leftFormula
        } else if let rightFormula = rightFormula {
            self.leftFormula = leftFormula
            self.connector = connector
            self.rightFormula = rightFormula
        } else {
            throw FormulaError.NoRightFormula
        }
        
        
    }
    /// Initialize a formula that is a variable
    /// - Parameter variable: the x variable
    init(variable : UInt) {
        self.connector = LogicConnectors.None
        self.variable = variable
    }
}
