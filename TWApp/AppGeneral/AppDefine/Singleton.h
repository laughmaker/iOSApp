//
//  ViewController.m
//  ARCDemo
//
//  Created by 振东 何 on 12-7-19.
//  Copyright (c) 2012年 开趣. All rights reserved.
//

#define kSingleton(classname) \
 \
static classname *shared##classname = nil; \
 \
+ (classname *)shared##Instance \
{ \
	@synchronized(self) \
	{ \
		if (shared##classname == nil) \
		{ \
			shared##classname = [[self alloc] init]; \
		} \
	} \
	 \
	return shared##classname; \
} \
 \
+ (id)allocWithZone:(NSZone *)zone \
{ \
	@synchronized(self) \
	{ \
		if (shared##classname == nil) \
		{ \
			shared##classname = [super allocWithZone:zone]; \
			return shared##classname; \
		} \
	} \
	 \
	return nil; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
	return self; \
} \
 \
