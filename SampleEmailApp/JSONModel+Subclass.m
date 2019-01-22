
#import "JSONModel+Subclass.h"

@implementation JSONModel (Subclass)

+ (Class)subclassForJSONValue:(NSDictionary *)dictionary {
    return self;
}

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError **)err {
    //bail early
    if (isNull(array)) {
        return nil;
    }

    //parse dictionaries to objects
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:[array count]];

    for (id d in array) {
        if ([d isKindOfClass:NSDictionary.class]) {
            JSONModelError *initErr = nil;
            Class class = [self subclassForJSONValue:(NSDictionary *)d];
            id obj = [[class alloc] initWithDictionary:d error:&initErr];
            if (obj == nil) {
                // Propagate the error, including the array index as the key-path component
                if ((err != nil) && (initErr != nil)) {
                    NSString *path = [NSString stringWithFormat:@"[%lu]", (unsigned long)list.count];
                    *err = [initErr errorByPrependingKeyPathComponent:path];
                }
                return nil;
            }

            [list addObject:obj];
        }
        else if ([d isKindOfClass:NSArray.class]) {
            [list addObjectsFromArray:[self arrayOfModelsFromDictionaries:d error:err]];
        }
        else {
            // This is very bad
        }
    }

    return list;
}

- (instancetype)initSubclassObjectWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    NSMutableArray * array = [NSMutableArray new];
    [array addObject:dict];
    NSMutableArray * subClassModelsArray = [[self class] arrayOfModelsFromDictionaries:array error:err];
    return [subClassModelsArray firstObject];
}

@end
