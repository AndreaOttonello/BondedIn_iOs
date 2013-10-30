//
//  DeveloperModel.h
//

#import <Foundation/Foundation.h>


/* {
 firstName = "Andrea";
 lastName = "Ottonello";
 company = "Devspark;
 city="Tandil"
 province= "Buenos Aires"
 pictureUrl="url
 publicProfileUrl= "urlProfile"
 other="......"
 }
 */


@interface DeveloperModel : NSObject

@property (retain) NSString *firstName;
@property (retain) NSString *lastName;
@property (retain) NSString *company;
@property (retain) NSString *province;
@property (retain) NSString *city;
@property (retain) NSString *pictureUrl;
@property (retain) NSString *publicProfileUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end