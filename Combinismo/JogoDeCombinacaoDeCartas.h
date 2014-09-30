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

// Canais de Notificação
extern NSString * const JogoDeCombinacaoDeCartasCartasCombinadasNotification;
extern NSString * const JogoDeCombinacaoDeCartasGameOverNotification;

// inicializador que deve ser utilizado! (Designated initializer)
- (instancetype) initComContagemDeCartas:(NSUInteger)contagem usandoBaralho:(Baralho *)baralho;

- (void)escolherCartaNoIndex:(NSUInteger)index;
- (Carta *)cartaNoIndex:(NSUInteger)index;
- (BOOL)validarContinuidadeDoJogo;
- (void)postarNotificacaoDeCombinacaoDaCarta:(Carta *)cartaA comACarta:(Carta *)cartaB comSaldo:(NSNumber *)saldo;
- (void)postarNotificacaoDeGameOver:(NSArray *)cartasRestantes;

@end
