//
//  database.m
//  Table
//
//  Created by Tyson Lindhardt on 2/1/14.
//  Copyright (c) 2014 Tyson Lindhardt. All rights reserved.
//

#import "database.h"

@implementation database
{
    NSMutableArray * db;
}

-(id)init
{
    if(self = [super init])
    {
        db = [[NSMutableArray alloc]init];
    }
    return self;
}

-(id)initWithArray:(NSMutableArray *)array
{
    if(self = [super init])
    {
        if(!array)
            db = [[NSMutableArray alloc]init];
        else
            db = array;
    }
    return self;
}

-(void)addUser:(NSString *)string
{
    [db addObject:string];
}

-(void)addUser:(NSString *)string atIndex:(NSInteger)index
{
    [db insertObject:string atIndex:index];
}

-(NSString *)getUser:(NSInteger)index
{
    return [db objectAtIndex:index];
}

-(void)removeUser:(NSInteger)index
{
    [db removeObjectAtIndex:index];
}

-(NSMutableArray *)getDB
{
    return db;
}

-(NSInteger)count
{
    return [db count];
}

-(void)savePlist:(NSMutableArray *)array
{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"database.plist"];
    NSString *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:array format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    if(plistData)
        [plistData writeToFile:plistPath atomically:YES];
}

-(void)saveBinary:(NSMutableArray *)array
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"database.db"];
    [NSKeyedArchiver archiveRootObject:array toFile:path];
}

@end
