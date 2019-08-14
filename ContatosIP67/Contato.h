//
//  Contato.h
//  ContatosIP67
//
//  Created by ios6998 on 10/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject <MKAnnotation>

@property NSString* nome;
@property NSString* telefone;
@property NSString* email;
@property NSString* endereco;
@property NSString* site;
@property (strong) UIImage *foto;
@property NSNumber* latitude;
@property NSNumber* longitude;


@end
