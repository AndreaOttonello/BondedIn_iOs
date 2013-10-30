//
//  DeveloperClient.m
//

#import "DeveloperClient.h"
#import "AFNetworking.h"

#define BaseURLString @"http://172.16.1.16:8000/"
#define Token @"1234abcd"

@implementation DeveloperClient

+ (id)sharedInstance {
    static DeveloperClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[DeveloperClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    }); 
    
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
        self.parameterEncoding = AFJSONParameterEncoding;
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
         
    }
    return self;
}

@end
