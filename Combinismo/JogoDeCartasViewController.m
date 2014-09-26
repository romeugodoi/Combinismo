//
//  JogoDeCartasViewController.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "JogoDeCartasViewController.h"
#import "JogoDeCombinacaoDeCartas.h"
#import "BaralhoDeJogo.h"
#import "CartaDeJogo.h"

@interface JogoDeCartasViewController ()

// Model
@property (strong, nonatomic) JogoDeCombinacaoDeCartas *jogo;

// View
@property (strong, nonatomic) IBOutletCollection(CartaView) NSArray *cartasView;
@property (weak, nonatomic) IBOutlet UILabel *pontuacaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificacaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *reiniciarJogoButton;

// UIKit Dynamics
@property (strong, nonatomic) UIDynamicAnimator *animador;
@property (strong, nonatomic) UIGravityBehavior *gravidade;

@end

@implementation JogoDeCartasViewController

#pragma mark - Lazy Instanciations

- (JogoDeCombinacaoDeCartas *)jogo
{
    if (!_jogo) _jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:self.cartasView.count
                                                                    usandoBaralho:[BaralhoDeJogo new]];
    return _jogo;
}

- (UIDynamicAnimator *)animador
{
    if (!_animador) {
        _animador = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animador;
}

- (UIGravityBehavior *)gravidade
{
    if (!_gravidade) _gravidade = [[UIGravityBehavior alloc] init];
    return _gravidade;
}

#pragma mark - Métodos privados

/**
 *  Vira a carta, e pede para atualizar a UI
 *
 *  @param cartaView Carta que o usuário escolheu
 */
- (IBAction)virarCarta:(CartaView *)cartaView
{
    NSUInteger cartaIndex = [self.cartasView indexOfObject:cartaView];
    
    [self.jogo escolherCartaNoIndex:cartaIndex];
    self.reiniciarJogoButton.hidden = NO;
    
    [self atualizarUI];
    
    if (cartaView.isAtiva) {
        [UIView transitionWithView:cartaView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:nil
                        completion:nil];
    }
    else {
        [self desvirarCarta:cartaView];
    }
}

- (void)desvirarCarta:(CartaView *)cartaView
{
    [UIView transitionWithView:cartaView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:nil
                    completion:nil];
}

- (IBAction)reiniciarJogo:(UIButton *)sender
{
    self.jogo= nil;
    self.pontuacaoLabel.text = self.notificacaoLabel.text = @"";
    self.reiniciarJogoButton.hidden = YES;
    
    [self atualizarUI];
}

/**
 *  Faz a atualização da UI refletindo a realidade atual do jogo
 */
- (void)atualizarUI
{
    for (NSUInteger i=0; i < self.cartasView.count; i++) {
        
        CartaDeJogo *carta = (CartaDeJogo *) [self.jogo cartaNoIndex:i];
        CartaView *cartaView = self.cartasView[i];
        
        BOOL desvirarCarta = (cartaView.isAtiva && !carta.isEscolhida && !carta.isCombinada);
        
        cartaView.ativa = carta.isEscolhida;
        cartaView.numero = [CartaDeJogo numerosString][carta.numero];
        cartaView.naipe = carta.naipe;
        
        // A carta já foi combinada, precisamos desabilitá-la
        cartaView.enabled = !(carta.isEscolhida && carta.isCombinada);
        
        if (desvirarCarta) {
            [self desvirarCarta:cartaView];
        }
        if (carta.isCombinada) {
            [self.gravidade addItem:cartaView];
        }
    }
    
    // Atualiza a pontuação
    self.pontuacaoLabel.text = [NSString stringWithFormat:@"Pontuação: %ld", (long)self.jogo.pontuacao];
}

- (void)notificacaoRecebida:(NSNotification *)notificacao
{
    Carta *cartaA = notificacao.userInfo[@"cartaA"];
    Carta *cartaB = notificacao.userInfo[@"cartaB"];
    NSNumber *saldo = notificacao.userInfo[@"saldo"];
    
    if (saldo.intValue < 0) {
        self.notificacaoLabel.textColor = [UIColor blackColor];
        self.notificacaoLabel.text = [NSString stringWithFormat:@"As cartas %@ e %@ não combinam!", cartaA.conteudo, cartaB.conteudo];
    }
    else {
        self.notificacaoLabel.textColor = [UIColor whiteColor];
        self.notificacaoLabel.text = [NSString stringWithFormat:@"As cartas %@ e %@ combinam!", cartaA.conteudo, cartaB.conteudo];
    }
}

#pragma mark - Ciclos de vida do Controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Adicionando o Behavior de gravidade ao animador
    [self.animador addBehavior:self.gravidade];
    
    // Registando as Notificações do Jogo
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notificacaoRecebida:)
               name:JogoDeCombinacaoDeCartasCartasCombinadasNotification
             object:self.jogo];
    
    // Mostramos qual foi a última pontuação do usuário
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger ultimaPontuacao = [ud integerForKey:@"ultimaPontuacao"];
    self.notificacaoLabel.text = [NSString stringWithFormat:@"Em seu último jogo, você fez %ld pontos!", (long)ultimaPontuacao];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Precisamos gravar a última pontuação do usuário para usarmos depois
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:self.jogo.pontuacao forKey:@"ultimaPontuacao"];
    [ud synchronize];
}

@end
