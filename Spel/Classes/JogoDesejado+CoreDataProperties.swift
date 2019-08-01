//
//  JogoDesejado+CoreDataProperties.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 30/07/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//
//

import Foundation
import CoreData


extension JogoDesejado {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JogoDesejado> {
        return NSFetchRequest<JogoDesejado>(entityName: "JogoDesejado")
    }

    @NSManaged public var descricao: String?
    @NSManaged public var imgJogo: String?
    @NSManaged public var nome: String?
    @NSManaged public var plataforma: String?
    @NSManaged public var vontade: Int32

}
