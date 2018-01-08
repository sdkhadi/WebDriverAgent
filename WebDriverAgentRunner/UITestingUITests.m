/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <XCTest/XCTest.h>

#import <WebDriverAgentLib/FBDebugLogDelegateDecorator.h>
#import <WebDriverAgentLib/FBConfiguration.h>
#import <WebDriverAgentLib/FBFailureProofTestCase.h>
#import <WebDriverAgentLib/FBWebServer.h>
#import <WebDriverAgentLib/XCTestCase.h>
#import "FBWebSocket.h"

@interface UITestingUITests : FBFailureProofTestCase <FBWebServerDelegate, FBWebSocketDelegate>
@end

@implementation UITestingUITests

+ (void)setUp
{
  [FBDebugLogDelegateDecorator decorateXCTestLogger];
  [FBConfiguration disableRemoteQueryEvaluation];
  [super setUp];
}

/**
 Never ending test used to start WebDriverAgent
 */

- (void)testServerRunner
{
    FBWebServer *webServer = [[FBWebServer alloc] init];
    webServer.delegate = self;
    [webServer startServing];
}

- (void)testSocketRunner
{
  FBWebSocket *webScoket = [[FBWebSocket alloc] init];
  webScoket.delegate = self;
  [webScoket startSocket];
}

#pragma mark - FBWebServerDelegate

- (void)webServerDidRequestShutdown:(FBWebServer *)webServer
{
  [webServer stopServing];
}

- (void)webSocketDidRequestShutdown:(nonnull FBWebSocket *)webSocket {
  [webSocket stopSocket];
}

@end
