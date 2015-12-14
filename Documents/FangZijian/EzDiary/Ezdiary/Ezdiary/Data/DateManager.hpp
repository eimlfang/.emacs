//
//  DateManger.hpp
//  Ezdiary
//
//  Created by Besprout's Mac Mini on 15/12/14.
//  Copyright © 2015年 Fang Zijian. All rights reserved.
//

#ifndef DateManager_hpp
#define DateManager_hpp

#define DateManagerInstance DateManager::instance()

#include <stdio.h>
#include <string>
class DateManager{
    int m_value;
    static DateManager *s_instance;
    DateManager(int v = 0)
    {
        m_value = v;
    }
public:
    tm *now(){
        time_t t = time(0);
        struct tm * now = localtime( & t );
        //    cout << (now->tm_year + 1900) << '-'
        //    << (now->tm_mon + 1) << '-'
        //    <<  now->tm_mday
        //    << endl;
        //
        delete now;
        return now;
    };
    static DateManager *instance()
    {
        if (!s_instance)
            s_instance = new DateManager;
        return s_instance;
    }
};

#endif /* DateManager_hpp */
