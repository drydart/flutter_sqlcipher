#import "FlutterSqlcipherPlugin.h"
#import <flutter_sqlcipher/flutter_sqlcipher-Swift.h>

@implementation FlutterSqlcipherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSqlcipherPlugin registerWithRegistrar:registrar];
}
@end
