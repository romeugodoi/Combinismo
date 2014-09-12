//
//  JogoDeCartasViewController.m
//  Combinismo
//
//  Created by Romeu Godoi on 11/09/14.
//  Copyright (c) 2014 CocoaHeadsBR. All rights reserved.
//

#import "JogoDeCartasViewController.h"
#import "BaralhoDeJogo.h"
#import "CartaDeJogo.h"

@interface JogoDeCartasViewController ()

// Model
@property (nonatomic) NSUInteger tentativas;
@property (strong, nonatomic) BaralhoDeJogo *baralhoJogo;

// View
@property (weak, nonatomic) IBOutlet UIButton *cartaButton;
@property (weak, nonatomic) IBOutlet UILabel *tentativasLabel;
@property (weak, nonatomic) IBOutlet UILabel *conteudoSuperior;
@property (weak, nonatomic) IBOutlet UILabel *conteudoInferior;

@end

@implementation JogoDeCartasViewController

- (UILabel *) conteudoInferior
{
    // Faz a rotação de 180º no conteudo inferior
    _conteudoInferior.transform = CGAffineTransformMakeRotation( 180 * M_PI  / 180 );
    return _conteudoInferior;
}

- (BaralhoDeJogo *)baralhoJogo
{
    if (!_baralhoJogo) _baralhoJogo = [BaralhoDeJogo new];
    return _baralhoJogo;
}

- (void)incrementaTentativasLabel:(UILabel *)label
{
    self.tentativas++;
    label.text = [NSString stringWithFormat:@"Tentativas: %lu", self.tentativas];
}

- (IBAction)virarCarta:(UIButton *)cartaButton
{
    [cartaButton setSelected: ![cartaButton isSelected]];
    
    if ([cartaButton isSelected]) {
        
        // Incrementa as tentativas
        [self incrementaTentativasLabel:self.tentativasLabel];
        
        // Seleciona carta
        CartaDeJogo *cartaSelecionada = (CartaDeJogo *)[self.baralhoJogo tirarCartaAleatoria];
        
        // Muda o conteudo das labels superiores e inferiores
        self.conteudoSuperior.text = self.conteudoInferior.text = cartaSelecionada.conteudo;
        self.conteudoSuperior.hidden = self.conteudoInferior.hidden = NO;
        
        // Muda o naipe central
        [cartaButton setTitle:cartaSelecionada.naipe forState:UIControlStateSelected];
    } else {
        // Volta o estado original das labels de conteudo
        self.conteudoSuperior.text = self.conteudoInferior.text = @"";
        self.conteudoSuperior.hidden = self.conteudoInferior.hidden = YES;
    }
}

@end
