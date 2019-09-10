#import "FlutterThailandProvincesPlugin.h"
#import <flutter_thailand_provinces/flutter_thailand_provinces-Swift.h>

@implementation FlutterThailandProvincesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterThailandProvincesPlugin registerWithRegistrar:registrar];
}
@end
