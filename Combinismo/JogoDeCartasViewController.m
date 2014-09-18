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

- (JogoDeCombinacaoDeCartas *)jogo
{
    if (!_jogo) _jogo = [[JogoDeCombinacaoDeCartas alloc] initComContagemDeCartas:self.cartasButton.count
                                                                    usandoBaralho:[BaralhoDeJogo new]];
    return _jogo;
}

- (IBAction)virarCarta:(UIButton *)cartaButton
{
    NSUInteger cartaIndex = [self.cartasButton indexOfObject:cartaButton];
    
    [self.jogo escolherCartaNoIndex:cartaIndex];
    
    [self atualizarUI];
}

- (void)atualizarUI
{
    for (NSUInteger i=0; i < self.cartasButton.count; i++) {
        
        Carta *carta = [self.jogo cartaNoIndex:i];
        UIButton *cartaButton = self.cartasButton[i];
        
        if (carta.isEscolhida) {
            
            [cartaButton setBackgroundImage:[UIImage imageNamed:@"cartaFrente"] forState:UIControlStateNormal];
            [cartaButton setTitle:carta.conteudo forState:UIControlStateNormal];
            
            if (carta.isCombinada) {
                cartaButton.enabled = NO;
            }
        }
        else {
            [cartaButton setBackgroundImage:[UIImage imageNamed:@"cartaVerso"] forState:UIControlStateNormal];
            [cartaButton setTitle:@"" forState:UIControlStateNormal];
        }
    }
    self.pontuacaoLabel.text = [NSString stringWithFormat:@"Pontuação: %ld", self.jogo.pontuacao];
}

@end
