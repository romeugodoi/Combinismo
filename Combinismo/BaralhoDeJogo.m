//
//  BaralhoDeJogo.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "BaralhoDeJogo.h"
#import "CartaDeJogo.h"

@implementation BaralhoDeJogo

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // Monta as cartas do baralho
        for (NSString *naipe in [CartaDeJogo naipesValidos]){
            for (NSUInteger numero = 1; numero <= [CartaDeJogo numeroMaximo]; numero++) {
                CartaDeJogo *carta = [[CartaDeJogo alloc] init];
                carta.numero = numero;
                carta.naipe = naipe;
                [self adicionarCarta:carta emCima:YES];
            }
        }
    }
    
    return self;
}

@end
