//
//  JogoDeCombinacaoDeCartas.m
//  Combinismo
//
//  Created by Romeu Godoi on 17/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "JogoDeCombinacaoDeCartas.h"

@interface JogoDeCombinacaoDeCartas()

@property (strong, nonatomic) NSMutableArray *cartas;
@property (nonatomic, readwrite) NSInteger pontuacao;

@end


@implementation JogoDeCombinacaoDeCartas

// Constantes de Configurações
static const int BONUS_POR_COMBINACAO = 4;
static const int PENALIDADE_POR_NAO_COMBINAR = 2;
static const int CUSTO_PARA_ESCOLHER = 1;

// Canais de Notificação
NSString * const JogoDeCombinacaoDeCartasCartasCombinadasNotification = @"br.com.cocoaheads.JogoDeCombinacaoDeCartasCartasCombinadasNotification";


#pragma mark - Inicializadores Designados

- (instancetype)init
{
    NSLog(@"Esta classe deve ser inicializada usando initComContagemDeCartas:usandoBaralho:");
    return nil;
}

- (instancetype)initComContagemDeCartas:(NSUInteger)contagem usandoBaralho:(Baralho *)baralho
{
    self = [super init];
    
    if (self) {
        for (int i=0; i < contagem; i++) {
            Carta *carta = [baralho tirarCartaAleatoria];
            
            if (carta) {
                [self.cartas addObject:carta];
            }
            else {
                return nil;
            }
        }
    }
    
    return self;
}

#pragma mark - Lazy Instanciations

- (NSMutableArray *)cartas
{
    if (!_cartas) _cartas = [NSMutableArray new];
    return _cartas;
}

#pragma mark - Métodos Privados

/**
 *  Escolhe uma carta em uma determinada posição da lista de cartas
 *
 *  @param index Posição da Carta
 */
- (void)escolherCartaNoIndex:(NSUInteger)index
{
    Carta *carta = [self cartaNoIndex:index];
    
    // Não faz sentido para cartas já foi combinadas
    if (!carta.isCombinada) {
        
        NSInteger pontuacaoAnterior = self.pontuacao;
        
        // Se a carta já estiver escolhida, volta ela para nao escolhida.
        if (carta.isEscolhida) {
            carta.escolhida = NO;
        }
        else {
            
            // ok. Nao combinada e não escolhida.
            
            // tenta combinar com outra carta
            // percorre todo o baralho procurando por cartas ESCOLHIDAS e NÃO COMBINADAS!
            for (Carta *outraCarta in self.cartas) {
                
                if (outraCarta.isEscolhida && !outraCarta.isCombinada) {
                    
                    // Pontuação da carta
                    int pontuacaoDaCombinacao = [carta combinar:@[outraCarta]];
                    
                    if (pontuacaoDaCombinacao) {
                        
                        // Bonifica os pontos
                        self.pontuacao += pontuacaoDaCombinacao * BONUS_POR_COMBINACAO;
                        
                        // Marca as cartas como combinadas
                        carta.combinada = YES;
                        outraCarta.combinada = YES;
                    }
                    else {
                        // Penaliza o jogador por não existir combinação
                        self.pontuacao -= PENALIDADE_POR_NAO_COMBINAR;
                        
                        // Volta a outra carta para não escolhida
                        outraCarta.escolhida = NO;
                    }
                    
                    NSNumber *saldo = [NSNumber numberWithInteger:( self.pontuacao - pontuacaoAnterior )];
                    [self postarNotificacaoDeCombinacaoDaCarta:carta comACarta:outraCarta comSaldo:saldo];
                }
            }
            
            // Debita o custo por escolher
            self.pontuacao -= CUSTO_PARA_ESCOLHER;
            carta.escolhida = YES;
        }
    }
}

- (Carta *)cartaNoIndex:(NSUInteger)index
{
    return index < self.cartas.count ? self.cartas[index] : nil;
}

- (void)postarNotificacaoDeCombinacaoDaCarta:(Carta *)cartaA comACarta:(Carta *)cartaB comSaldo:(NSNumber *)saldo
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:JogoDeCombinacaoDeCartasCartasCombinadasNotification
                      object:self
                    userInfo:@{ @"cartaA": cartaA, @"cartaB": cartaB, @"saldo": saldo }];
}

@end
