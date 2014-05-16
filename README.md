[![Build Status](https://travis-ci.org/itsthejb/JCSegueUserInfo.svg?branch=master)](https://travis-ci.org/itsthejb/NSURL-QueryDictionary)
[![Build Status](https://travis-ci.org/itsthejb/JCSegueUserInfo.svg?branch=develop)](https://travis-ci.org/itsthejb/NSURL-QueryDictionary)

#JCSegueUserInfo

Love `UIStoryboard`? Love `UIStoryboardSegue` even more? Hate the way the don't work as closely together as they could do? Try `JCSegueUserInfo`.

Imagine the common pattern where you'd like to trigger a storyboard segue programatically, but would also like to set a few properties on the destination view controller. Currently, you'd have to do something like this:

	...
		self.temporaryProperty = @"foo";
		self.anotherTemporaryProperty = @(1);
		[self performSegueWithIdentifier:@"MySegue" sender:self];
	}
	
	- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
		if ([segue.identifier isEqual:@"MySegue"]) {
    		SegueViewController *controller = segue.destinationViewController;
    		controller.someProperty = self.temporaryProperty;
    		controller.anotherProperty = self.anotherTemporaryProperty;   
    		self.temporaryProperty = nil;
    		self.anotherTemporaryProperty = nil;
		}
	}

With `JCSegueUserInfo` you can do:

	[self performSegueWithIdentifier:@"MySegue"
                              sender:self
                           	 userInfo:@{ @"someProperty" : @"foo",
			                           	  @"anotherProperty" : @(1) }];
                           	 
Much better!

`-[UIViewController performSegueWithIdentifier:sender:userInfo:` accepts an `NSDictionary` which is used to set arbitrary properties on the destination view controller instance using the standard `-[NSDictionary setValuesForKeysWithDictionary:]` method. What we do is swizzle the normal `-[UIViewController performSegueWithIdentifier:sender:]` to allow these values to be set on the destination controller if they have be stored using the category method.

**Enjoy!**

joncrooke@gmail.com
