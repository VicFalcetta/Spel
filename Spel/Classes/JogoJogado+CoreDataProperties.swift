//
//  JogoJogado+CoreDataProperties.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 30/07/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//
//

import Foundation
import CoreData


extension JogoJogado {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JogoJogado> {
        return NSFetchRequest<JogoJogado>(entityName: "JogoJogado")
    }

    @NSManaged public var descricao: String?
    @NSManaged public var imgJogo: String?
    @NSManaged public var nome: String?
    @NSManaged public var nota: Int32
    @NSManaged public var plataforma: String?

}
