//
//  Contato.m
//  ContatosIP67
//
//  Created by ios6998 on 10/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

@dynamic nome,endereco,telefone,site,email,latitude,longitude,foto;


//NSString *nome;
//NSString *endereco;
//NSString *telefone;
//NSString *site;
//NSString *email;



-(CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue ] , [ self.longitude doubleValue] );
}

-(NSString *)description{
    return [NSString stringWithFormat: @"Nome: %@, Telefone: %@, Endereço: %@, Site: %@, Email : %@", self.nome, self.telefone,self.endereco,self.site,self.email ];
}

-(NSString *)title{
    return self.nome;
}

-(NSString *)subtitle{
    return self.site;
}


@end
