using Uno;
using Uno.Time;
using Uno.Compiler.ExportTargetInterop;
using Uno.UX;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;

namespace Google.iOS
{
	[Require("Source.Include", "UIKit/UIKit.h")]
	//[Require("Source.Include", "MD5.h")]
	[Require("Source.Include", "GoogleMobileAds/DFPBannerView.h")]	
	[Require("Source.Include", "GoogleMobileAds/DFPRequest.h")]		
	extern(iOS) class DFPBannerNative : 
		Fuse.Controls.Native.iOS.LeafView, IDFPBanner 
	{


		IDFPBannerHost _host;

		public event ValueChangedHandler<String> IdChanged;		

		public DFPBannerNative(IDFPBannerHost host) : base(Create())
		{
			_host = host;
			this.IdChanged += OnIdChanged;
		}

		public override void Dispose()
		{
			base.Dispose();
			_host = null;
		}

		void OnIdChanged(object sender, ValueChangedArgs<string> args)
		{
			if (args.Value != null) {
				string _uuid = DeviceIdImpl().ToString();
				setAdUnitId(this.Handle, args.Value);
				// * Function that add device UUID to test Devices
				//setAdUnitId(this.Handle, args.Value, _uuid);
			}
		}		

		/*
		[Foreign(Language.ObjC)]
        extern(iOS) public string DeviceIdImpl ()
        @{
            NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
            return [oNSUUID UUIDString];
        @}
		*/		

		[Foreign(Language.ObjC)]
		static ObjC.Object Create()
		@{
			DFPBannerView *dfp = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
			return dfp;
		@}
		
		/*

		* Function that add device UUID to test Devices

		[Foreign(Language.ObjC)]
		public void setAdUnitId (ObjC.Object handle, string _ad_id, string _uuid)
		@{			
			DFPBannerView *dfp = (DFPBannerView*)handle;
			dfp.adUnitID = _ad_id;
			dfp.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            DFPRequest *request = [DFPRequest alloc];
			request.testDevices = @[ kGADSimulatorID, _uuid ];
            [dfp loadRequest:[DFPRequest request]];
		@}
		*/

		[Foreign(Language.ObjC)]
		public void setAdUnitId (ObjC.Object handle, string _ad_id)
		@{			
			DFPBannerView *dfp = (DFPBannerView*)handle;
			dfp.adUnitID = _ad_id;
			dfp.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            [dfp loadRequest:[DFPRequest request]];
		@}		
	}
}