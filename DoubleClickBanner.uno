using Uno;
using Uno.Time;
using Uno.Compiler.ExportTargetInterop;
using Uno.UX;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;
using Fuse.Scripting;

namespace Google
{


	internal interface IDFPBannerHost
	{
		//void OnIdChanged(ValueChangedArgs<string> new_id);
	}

	internal interface IDFPBanner
	{

	}

	[Require("Cocoapods.Podfile.Target", "pod 'Google-Mobile-Ads-SDK'")]
	public partial class DFPBanner : Panel, IDFPBannerHost
	{

		string _ad_id;
		public string Id {
			get {
				return _ad_id;
			}
			set {
				var s = _ad_id;
				_ad_id = value;
				OnIdChanged(value, s);
			}
		}

		IDFPBanner BannerView
		{
			get { return NativeView as IDFPBanner; }
		}

		protected override IView CreateNativeView()
		{
			if defined(Android)
			{
				return new Google.Android.DFPBannerNative(this, _ad_id);
			}
			else if defined(iOS)
			{
				return new Google.iOS.DFPBannerNative(this);
			}
			else
			{
				return base.CreateNativeView();
			}
		}

		public event ValueChangedHandler<String> IdChanged;		

		void OnIdChanged(string value, string orig)
		{
			if (IdChanged != null)
				IdChanged(this, new ValueChangedArgs<string>(value));
		}

	}
}