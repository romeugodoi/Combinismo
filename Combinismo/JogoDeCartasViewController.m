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

@interface JogoDeCartasViewController ()

// Model
@property (strong, nonatomic) JogoDeCombinacaoDeCartas *jogo;

// View
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cartasButton;
@property (weak, nonatomic) IBOutlet UILabel *pontuacaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificacaoLabel;

@end

@implementation JogoDeCartasViewController

#pragma mark - Lazy Instanciations

- (JogoDeCombinacaoDeCartas *)jogo
{
    if (!_jogo) _jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:self.cartasButton.count
                                                                    usandoBaralho:[BaralhoDeJogo new]];
    return _jogo;
}

#pragma mark - Métodos privados

/**
 *  Vira a carta, e pede para atualizar a UI
 *
 *  @param cartaButton Carta que o usuário escolheu
 */
- (IBAction)virarCarta:(UIButton *)cartaButton
{
    NSUInteger cartaIndex = [self.cartasButton indexOfObject:cartaButton];
    
    [self.jogo escolherCartaNoIndex:cartaIndex];
    
    [self atualizarUI];
}

/**
 *  Faz a atualização da UI refletindo a realidade atual do jogo
 */
- (void)atualizarUI
{
    for (NSUInteger i=0; i < self.cartasButton.count; i++) {
        
        Carta *carta = [self.jogo cartaNoIndex:i];
        UIButton *cartaButton = self.cartasButton[i];
        
        if (carta.isEscolhida) {
            
            [cartaButton setBackgroundImage:[UIImage imageNamed:@"cartaFrente"] forState:UIControlStateNormal];
            [cartaButton setTitle:carta.conteudo forState:UIControlStateNormal];
            
            // A carta já foi combinada, precisamos desabilitá-la
            if (carta.isCombinada) {
                cartaButton.enabled = NO;
            }
        }
        else {
            // Viramos a carta para o verso novamente
            [cartaButton setBackgroundImage:[UIImage imageNamed:@"cartaVerso"] forState:UIControlStateNormal];
            [cartaButton setTitle:@"" forState:UIControlStateNormal];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Registando as Notificações do Jogo
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notificacaoRecebida:)
               name:JogoDeCombinacaoDeCartasCartasCombinadasNotification
             object:self.jogo];
    
    // Mostramos qual foi a última pontuação do usuário
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger ultimaPontuacao = [ud integerForKey:@"ultimaPontuacao"];
    self.pontuacaoLabel.text = [NSString stringWithFormat:@"Em seu último jogo, você fez %ld pontos!.", (long)ultimaPontuacao];
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
