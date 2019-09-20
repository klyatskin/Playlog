//
//  PlaylogTests.m
//  PlaylogTests
//
//  Created by Konstantin Klyatskin on 2019-09-19.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Randomize.h"

@interface PlaylogTests : XCTestCase

@end

@implementation PlaylogTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testRandomIndexes {  // check random selection
    NSArray *random;
    
    NSLog(@"----------- capacity > length");
    random = [NSArray arrayOfRandomIndexesWithCapacity:3 fromLength:2];
    NSLog(@"%@",random);
    XCTAssertNil(random, @"Should be nil!");

    NSLog(@"----------- capacity < length");
    for (int i=0; i<10; i++) {
        random = [NSArray arrayOfRandomIndexesWithCapacity:2 fromLength:3];
        NSLog(@"%@",random);
        XCTAssertTrue(random.count ==2 , @"Should not be nil!");
    }
    
    NSLog(@"----------- capacity = length");
    for (int i=0; i<10; i++) {
        random = [NSArray arrayOfRandomIndexesWithCapacity:3 fromLength:3];
        NSLog(@"%@",random);
        XCTAssertTrue(random.count ==3 , @"Should not be nil!");
    }

    NSLog(@"----------- capacity & length are large");
    for (int i=0; i<3; i++) {
        random = [NSArray arrayOfRandomIndexesWithCapacity:99 fromLength:10000];
        NSLog(@"%@",random);
        XCTAssertTrue(random.count ==99 , @"Should not be nil!");
    }

    NSLog(@"----------- capacity & length are large");
    for (int i=0; i<3; i++) {
        random = [NSArray arrayOfRandomIndexesWithCapacity:100 fromLength:100];
        NSLog(@"%@",random);
        XCTAssertTrue(random.count ==100 , @"Should not be nil!");
    }

}


@end
