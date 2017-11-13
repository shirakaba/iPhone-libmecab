//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//  This is not automatically picked up by a consumer of the static library if simply exposed as a
//  public header; the consumer needs to set it explicitly as the bridging header for its target.
//  May be able to get around that by making a framework.
//

/* These two imports DO work when the consumer has this file explicitly set as the bridging header.  */
// #import "../objc_bridging/MecabObjC.h"
// #import "../objc_bridging/Node.h"

/* Trying to make it relative to the framework so that this bridging header gets bundled in. */
#import <MecabFramework/MecabObjC.h>
#import <MecabFramework/Node.h>
