using System;
namespace msdfgen
{
	[CRepr]
	public struct Shape
	{
		[CRepr]
		public struct Bounds
		{
			public double Left;
			public double Bottom;
			public double Right;
			public double Top;
		}

		// msdfgen_SizeOfShape
		uint8[40] arr;

		public void Normalize() mut
		{
			msdfgen_shape_normalize(&this);
		}

		public Bounds GetBounds() mut => msdfgen_shape_getBounds(&this);
		
		[CLink]
		private static extern void msdfgen_shape_normalize(Shape *shape);

		[CLink]
		private static extern Bounds msdfgen_shape_getBounds(Shape *shape);
	}
}
