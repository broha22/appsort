#import "stats.h"
static ASStatManager *manager;

@interface NSUserDefaults (ASStatManager) {
}
- (id)objectForKey:(id)key inDomain:(id)d;
- (void)setObject:(id)r forKey:(id)key inDomain:(id)d;
- (id)persistentDomainForName:(NSString *)name;
@end
@interface SBApplication : UIApplication
- (id)bundleIdentifier;
@end

@implementation ASStatManager
+ (id)sharedInstance {
	if (manager == nil) {
		manager = [[ASStatManager alloc] init];
	}
	return manager;
}
- (NSString *)launchCountForIdentifier:(NSString *)identifier {
	NSDictionary *lookup = [[NSUserDefaults standardUserDefaults] objectForKey:identifier inDomain:@"com.broganminer.ASStatManager"];
	return [[lookup objectForKey:@"count"] stringValue];
}
- (NSString *)screenTimeForIdentifier:(NSString *)identifier {
	NSDictionary *lookup = [[NSUserDefaults standardUserDefaults] objectForKey:identifier inDomain:@"com.broganminer.ASStatManager"];
	return [[lookup objectForKey:@"screenTime"] stringValue];
}
- (NSArray *)recentApplications {
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"recents" inDomain:@"com.broganminer.ASStatManager"];
}
@end

%hook SBApplication
- (void)processDidLaunch:(id)arg1 {
	NSMutableDictionary *oldStats = [[[NSUserDefaults standardUserDefaults] objectForKey:[self bundleIdentifier] inDomain:@"com.broganminer.ASStatManager"] mutableCopy];

	NSInteger count = 0;
	if (oldStats == nil) {
		oldStats = [[NSMutableDictionary alloc] init];
	}
	else {
		count = [[oldStats objectForKey:@"count"] intValue];
	}
	count++;
	[oldStats setObject:[NSNumber numberWithInt:count] forKey:@"count"];

	[[NSUserDefaults standardUserDefaults] setObject:oldStats forKey:[self bundleIdentifier] inDomain:@"com.broganminer.ASStatManager"];
	[oldStats release];

	NSMutableArray *oldRecents = [[[NSUserDefaults standardUserDefaults] objectForKey:@"recents" inDomain:@"com.broganminer.ASStatManager"] mutableCopy];
	if (oldRecents == nil) {
		oldRecents = [[NSMutableArray alloc] init];
	}
	if ([oldRecents containsObject:[self bundleIdentifier]]) {
		[oldRecents removeObject:[self bundleIdentifier]];
	}
	[oldRecents insertObject:[self bundleIdentifier] atIndex:0];
	[[NSUserDefaults standardUserDefaults] setObject:oldRecents forKey:@"recents" inDomain:@"com.broganminer.ASStatManager"];
	[oldRecents release];

	%orig;
}
- (void)willActivate {
	NSMutableDictionary *oldStats = [[[NSUserDefaults standardUserDefaults] objectForKey:[self bundleIdentifier] inDomain:@"com.broganminer.ASStatManager"] mutableCopy];
	if (oldStats == nil) {
		oldStats = [[NSMutableDictionary alloc] init];
	}
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init]; 
	[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
	NSString *date = [dateFormatter stringFromDate:[NSDate date]];
	[dateFormatter release];
	[oldStats setObject:date forKey:@"lastOpened"];
	[[NSUserDefaults standardUserDefaults] setObject:oldStats forKey:[self bundleIdentifier] inDomain:@"com.broganminer.ASStatManager"];
	[oldStats release];
	%orig;
}
- (void)_didSuspend {
	NSMutableDictionary *oldStats = [[[NSUserDefaults standardUserDefaults] objectForKey:[self bundleIdentifier] inDomain:@"com.broganminer.ASStatManager"] mutableCopy];
	if (oldStats == nil) {
		oldStats = [[NSMutableDictionary alloc] init];
	}
	NSString *lastOpened = [oldStats objectForKey:@"lastOpened"];
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init]; 
	[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
	NSDate *lastOpenedDate = [dateFormatter dateFromString:lastOpened];
	NSDate *now = [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];

	NSInteger secondsOpen = [now timeIntervalSinceDate:lastOpenedDate];
	NSInteger oldSeconds = [[oldStats objectForKey:@"screenTime"] intValue];

	[dateFormatter release];
	[oldStats setObject:[NSNumber numberWithInteger:(secondsOpen+oldSeconds)] forKey:@"screenTime"];
	[[NSUserDefaults standardUserDefaults] setObject:oldStats forKey:[self bundleIdentifier] inDomain:@"com.broganminer.ASStatManager"];
	[oldStats release];
	%orig;
}
%end
%ctor {
	/*
	NSDictionary *bs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.broganminer.ASStatManager"];
	for (NSString *key in [bs allKeys]) {
		[[NSUserDefaults standardUserDefaults] setObject:nil forKey:key inDomain:@"com.broganminer.ASStatManager"];
	}
	*/
}