using Uno;
using Uno.Time;
using Uno.Compiler.ExportTargetInterop;
using Uno.UX;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;

namespace Google.Android
{

    [Require("Gradle.Dependency.Compile", "com.google.android.gms:play-services-ads:11.0.0")]
    [ForeignInclude(Language.Java,
                    "com.google.android.gms.ads.doubleclick.PublisherAdRequest",
                    "com.google.android.gms.ads.doubleclick.PublisherAdView",
					"com.google.android.gms.ads.AdSize")]
	extern(Android) class DFPBannerNative : 
		Fuse.Controls.Native.Android.LeafView, IDFPBanner
	{


		IDFPBannerHost _host;
		IDisposable _valueChangedEvent;

		public event ValueChangedHandler<String> IdChanged;		

		public DFPBannerNative(IDFPBannerHost host, string _ad_id) : base(Create(_ad_id))
		{
			_host = host;
			this.IdChanged += OnIdChanged;
			//Init(Handle, OnDateChanged);
		}

		public override void Dispose()
		{
			base.Dispose();
			_host = null;
		}

		void OnIdChanged(object sender, ValueChangedArgs<string> args)
		{
			if (args.Value != null) {
				setAdUnitId(this.Handle, args.Value);
			}
		}		

		[Foreign(Language.Java)]
		static Java.Object Create(string _ad_id)
		@{
			
			PublisherAdView mAdView = new PublisherAdView(@(Activity.Package).@(Activity.Name).GetRootActivity());
            mAdView.setAdSizes(AdSize.SMART_BANNER);
            mAdView.setAdUnitId(_ad_id);
            
            //PublisherAdRequest publisherAdRequestBuilder = new PublisherAdRequest.Builder();
            //mAdView.loadAd(PublisherAdRequestBuilder.build());
			mAdView.loadAd(new PublisherAdRequest.Builder().build());
            return  mAdView;			
			//return new android.widget.DatePicker(@(Activity.Package).@(Activity.Name).GetRootActivity());
		@}

		[Foreign(Language.Java)]
		public void setAdUnitId(Java.Object Handle, string _new_ad_id) 
		@{			
			PublisherAdView mAdView = (PublisherAdView)Handle;
			mAdView.setAdUnitId(_new_ad_id);
			//mAdView.loadAd(PublisherAdRequestBuilder.build());
			mAdView.loadAd(new PublisherAdRequest.Builder().build());
		@}
		
	}
}