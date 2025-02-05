#import "VerovioWrapper.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Verovio/Verovio-umbrella.h>

@interface VerovioWrapper()
@property (nonatomic, assign) vrv::Toolkit *toolkit;

@end

@implementation VerovioWrapper

- (instancetype)init
{
    if ((self = [super init])) {
        NSBundle *verovioBundle = [NSBundle bundleWithIdentifier:@"digital.rism.VerovioFramework"];
        NSString *resourcePath = [verovioBundle URLsForResourcesWithExtension:@"xml"
                                                                 subdirectory:@"data"].firstObject.URLByDeletingLastPathComponent.path;
        
        self.toolkit = new vrv::Toolkit(false);
        self.toolkit->SetResourcePath([resourcePath cStringUsingEncoding:NSUTF8StringEncoding]);
        
        //NSString *foo = @"Foo";
        std::string path = std::string([resourcePath UTF8String]);
        NSLog(@"%s%@","from VerovioWrapper.mm 1\n", [NSString stringWithCString:path.c_str() encoding:NSUTF8StringEncoding]);
        
        self.toolkit->SetResourcePath(path);

        vrv::EnableLog(false);
        
        std:string vrvVer = vrv::GetVersion();
        NSLog(@"%@",[NSString stringWithCString:vrvVer.c_str() encoding:NSUTF8StringEncoding]);
    }
    return self;
}

- (void)dealloc
{
    delete self.toolkit;
}

- (NSString *)renderPageForURL:(NSURL*)url withSize:(CGSize)size withPage:(int)page
{
    std::string filePath = std::string([url.path cStringUsingEncoding: NSUTF8StringEncoding]);
    NSLog(@"%s%@","from VerovioWrapper.mm 2\n", [NSString stringWithCString:filePath.c_str() encoding:NSUTF8StringEncoding]);
    
    // load file into verovio
    self.toolkit->LoadFile(filePath);
    
    // set size and scale
    [self setPageSize:size scale:50];
    
    std::string svg = self.toolkit->RenderToSVG(page);
    return [NSString stringWithCString:svg.c_str() encoding:NSUTF8StringEncoding];
}

- (int)getPageCount:(NSURL*)url
{
    std::string filePath = std::string([url.path cStringUsingEncoding: NSUTF8StringEncoding]);

    // load file into verovio
    self.toolkit->LoadFile(filePath);
    
    // get page count
    int rr = self.toolkit->GetPageCount();
    return rr;
}

- (void)setPageSize:(CGSize)size scale:(NSInteger)scale
{
    float scaleFloat = (float) scale;
    CGFloat scaledHeight = size.height * 100.f / scaleFloat;
    CGFloat scaledWidth = size.width * 100.f / scaleFloat;
    CGSize scaledSize = CGSizeMake(scaledWidth, scaledHeight);

    [self setOptionsSize:scaledSize scale:scale];
    self.toolkit->RedoLayout();
}

- (void)setOptionsSize:(CGSize)size scale:(NSInteger)scale
{
    NSString *options = [NSString stringWithFormat:@"{ \"pageHeight\": %d, \"pageWidth\": %d, \"scale\": %ld, \"adjustPageWidth\": false, \"adjustPageHeight\": true }", (int)size.height, (int)size.width, (long)scale];

    std::string cOptions = std::string([options cStringUsingEncoding: NSUTF8StringEncoding]);

    self.toolkit->SetOptions(cOptions);
}

@end
