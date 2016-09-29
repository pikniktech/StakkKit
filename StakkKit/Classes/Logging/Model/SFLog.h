//
//  SFLog.h
//  Pods
//
//  Created by Derek on 28/9/2016.
//
//

#import <CocoaLumberjack/CocoaLumberjack.h>

#undef LOG_ASYNC_ENABLED

#define SFLOG_FLAG_ERROR    (1 << 10)  // 0...0000001
#define SFLOG_FLAG_DB       (1 << 11)  // 0...0000010
#define SFLOG_FLAG_API      (1 << 12)  // 0...0000100
#define SFLOG_FLAG_DEBUG    (1 << 13)  // 0...0001000

#define SFLOG_LEVEL_OFF     0
#define SFLOG_LEVEL_ERROR   (SFLOG_FLAG_ERROR)
#define SFLOG_LEVEL_DB      (SFLOG_LEVEL_ERROR | SFLOG_FLAG_DB   )
#define SFLOG_LEVEL_API     (SFLOG_LEVEL_DB    | SFLOG_FLAG_API  )
#define SFLOG_LEVEL_DEBUG   (SFLOG_LEVEL_API   | SFLOG_FLAG_DEBUG)

#define SFLOG_LEVEL_ALL SFLOG_LEVEL_DEBUG

typedef NS_OPTIONS(NSUInteger, SFLogFlag){
    SFLogFlagError      = SFLOG_FLAG_ERROR,
    SFLogFlagDatabase   = SFLOG_FLAG_DB,
    SFLogFlagAPI        = SFLOG_FLAG_API,
    SFLogFlagDebug      = SFLOG_FLAG_DEBUG
};

typedef NS_ENUM(NSUInteger, SFLogLevel){
    SFLogLevelOff       = SFLOG_LEVEL_OFF,
    SFLogLevelError     = SFLOG_LEVEL_ERROR,
    SFLogLevelDatabase  = SFLOG_LEVEL_DB,
    SFLogLevelAPI       = SFLOG_LEVEL_API,
    SFLogLevelDebug     = SFLOG_LEVEL_DEBUG,
    SFLogLevelAll       = SFLOG_LEVEL_ALL
};

#define SFLOG_ASYNC_ENABLED NO

#define SFLOG_ASYNC_ERROR    ( NO && SFLOG_ASYNC_ENABLED)
#define SFLOG_ASYNC_DB       (YES && SFLOG_ASYNC_ENABLED)
#define SFLOG_ASYNC_API      (YES && SFLOG_ASYNC_ENABLED)
#define SFLOG_ASYNC_DEBUG    (YES && SFLOG_ASYNC_ENABLED)

#define SFLogError(frmt, ...)   LOG_MAYBE(SFLOG_ASYNC_ERROR,   SFLOG_LEVEL_ALL, SFLOG_FLAG_ERROR,   0, nil, __PRETTY_FUNCTION__, CustomLoggingFormat("[ERROR]", frmt), ##__VA_ARGS__)
#define SFLogDB(frmt, ...)      LOG_MAYBE(SFLOG_ASYNC_DB,      SFLOG_LEVEL_ALL, SFLOG_FLAG_DB,      0, nil, __PRETTY_FUNCTION__, CustomLoggingFormat("[DATABASE]", frmt), ##__VA_ARGS__)
#define SFLogAPI(frmt, ...)     LOG_MAYBE(SFLOG_ASYNC_API,     SFLOG_LEVEL_ALL, SFLOG_FLAG_API,     0, nil, __PRETTY_FUNCTION__, CustomLoggingFormat("[API]", frmt), ##__VA_ARGS__)
#define SFLogDebug(frmt, ...)   LOG_MAYBE(SFLOG_ASYNC_DEBUG,   SFLOG_LEVEL_ALL, SFLOG_FLAG_DEBUG,   0, nil, __PRETTY_FUNCTION__, CustomLoggingFormat("[DEBUG]", frmt), ##__VA_ARGS__)

#define CustomLoggingFormat(flag, frmt) (@"\n"flag"\n%s[Line %d]\n"frmt"\n"), __PRETTY_FUNCTION__, __LINE__
