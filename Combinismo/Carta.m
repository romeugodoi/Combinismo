//
//  Carta.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "Carta.h"

@implementation Carta

//
//  combinar: Vai retornar uma pontuação nos
//  dizendo o quão boa é a combinação.
//  0 significa nenhuma combinação
//  > 0 significa melhores combinações
//
- (int) combinar:(NSArray *)outrasCartas
{
    int score = 0;
    
    for (Carta *carta in outrasCartas) {
        if ([carta.conteudo isEqualToString:self.conteudo]) {
            score = 1;
        }
    }
    return score;
}

@end
