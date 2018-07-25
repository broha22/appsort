@interface ASStatManager : NSObject
+ (id)sharedInstance;
- (NSString *)launchCountForIdentifier:(NSString *)identifier;
- (NSArray *)recentApplications;
- (NSString *)screenTimeForIdentifier:(NSString *)identifier;
@end