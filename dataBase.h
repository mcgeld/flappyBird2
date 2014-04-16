//
//  dataBase.h
//  flappyBird2
//
//  Created by Brittny Wright on 4/16/14.
//  Copyright (c) 2014 Malcolm Geldmacher. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface database : NSObject

-(void)removeUser:(NSInteger)index;
-(NSString *)getUser:(NSInteger)index;
-(void)addUser:(NSString *)string;
-(void)addUser:(NSString *)string atIndex:(NSInteger)index;
-(NSMutableArray *)getDB;
-(NSInteger)count;
-(id)initWithArray:(NSMutableArray *)array;
-(void)savePlist:(NSMutableArray *)array;
-(void)saveBinary:(NSMutableArray *)array;
@end

