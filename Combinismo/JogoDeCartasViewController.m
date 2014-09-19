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
    self.pontuacaoLabel.text = [NSString stringWithFormat:@"Pontuação: %ld", self.jogo.pontuacao];
}

#pragma mark - Ciclos de vida do Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Mostramos qual foi a última pontuação do usuário
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger ultimaPontuacao = [ud integerForKey:@"ultimaPontuacao"];
    self.pontuacaoLabel.text = [NSString stringWithFormat:@"Em seu último jogo, você fez %ld pontos!.", ultimaPontuacao];
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
