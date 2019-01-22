
#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface JSONModel (Subclass)

+ (Class)subclassForJSONValue:(NSDictionary *)dictionary;
+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError **)err;
- (instancetype)initSubclassObjectWithDictionary:(NSDictionary *)dict error:(NSError **)err;

@end
