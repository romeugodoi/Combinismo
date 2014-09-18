//
//  JogoDeCombinacaoDeCartas.h
//  Combinismo
//
//  Created by Romeu Godoi on 17/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baralho.h"
#import "Carta.h"

@interface JogoDeCombinacaoDeCartas : NSObject

@property (nonatomic, readonly) NSInteger pontuacao;

// inicializador que deve ser utilizado! (Designated initializer)
- (instancetype) initComContagemDeCartas:(NSUInteger)contagem usandoBaralho:(Baralho *)baralho;

- (void) escolherCartaNoIndex:(NSUInteger)index;
- (Carta *) cartaNoIndex:(NSUInteger)index;

@end
