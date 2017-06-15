# Fuse DoubleClickBanner

Show DoubleClick banner hosted ads on your Fuse application.

## Usage

It's an example project. Copy the following files to your project

* DoubleClickBanner.uno
* DoubleClickBannerNative.Android.uno
* DoubleClickBannerNative.iOS.uno
* dfp-ios.uxl
* Podfile

Then, you can use on your .ux files as follows

```
				<NativeViewHost>
					<Google.DFPBanner Id="{banner_id}" />
				</NativeViewHost>

```
## Compile and run

Since it requires CocoaPods on iOS, you should use the following commmands

**Run on real device**: ```fuse build -t=iOS -DCOCOAPODS -r```

**Preview on device simulator**: ```fuse build -t=iOS -DCOCOAPODS -r```

## Requirements

* Fuse 1.0 
* Cocoapods (if working on OSX) It should be enough just to ```run sudo gem install cocoapods```

## Release Notes

**June 15, 2017**

* Initial version
* Further testing is needded on iOS
* Android displaying Ads on device