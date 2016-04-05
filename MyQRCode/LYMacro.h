//
//  LYMacro.h
//  MyQRCode
//
//  Created by Leo on 16/3/29.
//  Copyright © 2016年 Leo. All rights reserved.
//

#ifndef LYMacro_h
#define LYMacro_h

/**
 *  永久存储对象
 *
 *  @param object 需要存储的对象
 *  @param key    对应的key
 */
#define PERMANENT_SET_OBJECT(object, key)\
({\
NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];\
[defaults setObject:object forKey:key]; \
[defaults synchronize];\
})

/**
 *  取出永久存储的对象
 *  @param  key 对象对应的key
 *  @return key所对应的对象
 */
#define PERMANENT_GET_OBJECT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define SHOWALERT(_title_,_message_) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_title_ message:_message_ delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
[alertView show];

#define SHOWALERTWithDelegate(_title, _message, _delegate, _cancel, _sure) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:_delegate cancelButtonTitle:_cancel otherButtonTitles:_sure, nil];\
[alertView show];

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

#endif /* LYMacro_h */
