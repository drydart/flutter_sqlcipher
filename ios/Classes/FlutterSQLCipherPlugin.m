#import "FlutterSQLCipherPlugin.h"
#import <flutter_sqlcipher/flutter_sqlcipher-Swift.h>

@implementation FlutterSQLCipherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSQLCipherPlugin registerWithRegistrar:registrar];
}
@end
