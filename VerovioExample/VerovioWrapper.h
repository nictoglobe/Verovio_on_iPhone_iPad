#import <Foundation/Foundation.h>

typedef struct CGSize CGSize;

NS_ASSUME_NONNULL_BEGIN

@interface VerovioWrapper: NSObject

- (instancetype)init;

- (NSString *)renderPageForURL:(NSURL*)url withSize:(CGSize)size withPage: (int)page NS_SWIFT_NAME(renderPage(url:size:page:));

- (int)getPageCount:(NSURL*)url;

@end

NS_ASSUME_NONNULL_END
