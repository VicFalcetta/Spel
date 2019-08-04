//
//  Achievements.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 02/08/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//

import Foundation

class Achievements{
    let titulo = ["Beam me up, Scotty","Two number 9s, a 9 large", "Well, it is something", "The answer is 42"]
    let desc = ["Comece o aplicativo pela primeira vez","Tenha 9 jogos na lista de Jogados e 9 na lista Desejados","Tenha 1 jogo em alguma lista","Tenha 42 jogos registrados no total"]
    
    func retornaTitulo(num: Int) -> String{
        return titulo[num]
    }
    
    func retornaDescricao(num: Int) -> String{
        return desc[num]
    }
}
